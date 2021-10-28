#******************************************************************************
#   ＊ ＴＥＳ本体 ＊
#                       for RGSS3
#        Ver 1.02   2014.04.06
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    ◆機能説明
    　テキストファイルで作成したイベントを変換・実行するための素材です。
      使い方等はＴＥＳドキュメントを参照して下さい。
=end

module TesManager
  #--------------------------------------------------------------------------
  # ○ keys
  #--------------------------------------------------------------------------
  def self.keys
    ## !!!!! 重要 !!!!!
    ## この下の行に、128文字の半角英数字のランダムな文字列を書き込んでください。
    ## ↓はサンプルです。
    ## このキーを知られると、プレイヤーがシナリオをデコードできてしまいます。
    ## 使う人がご自身で書き換えてください。
#   "36f312186e4f8912f5439f3689c880ccff9f99db1ecc6594a15cbba51ea2236b24888a9e45d1b3340f0b5b935141127b0ad635e2ed2bed22a8cd364ad4161129"
  end
  #--------------------------------------------------------------------------
  # ○ code
  #--------------------------------------------------------------------------
  def self.code
    ## !!!!! 重要 !!!!!
    ## この下の行に、128文字の半角英数字のランダムな文字列を書き込んでください。
    ## ↓はサンプルです。
    ## このキーを知られると、プレイヤーがシナリオをデコードできてしまいます。
    ## 使う人がご自身で書き換えてください。
#   "a6a70c075174428c18cfbe0b392bf9f42bad7fa4d9c9f1d1a18c677af44197cf63dc955417f45320c72d87b013e5eb2a5a7056518873d0ebefccdef90d119736"
  end
end

module TES
  # ---------- コンフィグ ---------------------------------------------------
  
  #◆ 外部シナリオ（テキストファイル）の保管フォルダの場所
  SOURCE_DIR = "../Scenario/"
  
  #◆ 変換後のメインＴＥＳファイルの保管場所
  #   ※暗号化されるフォルダを指定して下さい。
  MAIN_DIR  = "Data/"
  
  #◆ 配布用パッチＴＥＳファイルの保管場所
  PATCH_DIR = "Patch/"
  
  #◆ パッチを有効/無効
  PATCH_ENABLE = false
  
  #◆ ＴＥＳ変換モードの起動キー
  #　 ※デバッグモードでのみ可能
  CONVERT_MODE_BTN = :F8
  
  #◆ 圧縮暗号化モード
  #   WHITE-FLUTE様の「Comp-SaveDataEX セーブデータ圧縮暗号化スクリプト」を
  #   導入済みの場合、解析・改竄が困難な状態で変換が可能です。
  #   ※解析・改竄が困難にはなりますが、100%防止するものではありません。
  #   ※未導入の場合はtrueに設定しないで下さい。
  WF_COMP_MODE = false
  
  #◆ TES変換のロック
  #   ゲームやパッチの配布後等、TES変換したくないフォルダを指定して下さい。
  TES_LOCK = []
end

#============================================================================
#   設定はここまで。以下変更禁止
#============================================================================





#----------------------------------------------------------------------------
# ◇ 例外の定義をいくつか
#----------------------------------------------------------------------------
# リンク失敗時に発生する例外
class TesLinkError     < StandardError;end

# シナリオファイル読込エラー
class TesLoadError     < StandardError;end

# ＴＥＳコマンド分割エラー
class TesSplitError    < StandardError;end

# ＴＥＳ文法エラー
class TesSyntaxError   < StandardError;end

# ＴＥＳ検証エラー
class TesValidateError < StandardError;end

# TES変換失敗の例外
class TesConvertError  < StandardError;end

# TES保存失敗の例外
class TesSaveError     < StandardError;end


#----------------------------------------------------------------------------
# ◇ ツクール連携
#----------------------------------------------------------------------------
class << DataManager
  #--------------------------------------------------------------------------
  # ● モジュール初期化 TES管理もついでに初期化
  #--------------------------------------------------------------------------
  alias sui_tes_init init
  def init
    sui_tes_init
    TesManager.init
  end
end

class Game_Interpreter
  #--------------------------------------------------------------------------
  # ● 注釈からTESにリンクする。
  #     タグ１：<link label> 全シナリオファイルからlabelを探してリンク
  #     タグ２：<link label file>fileからlabelを探してリンク
  #--------------------------------------------------------------------------
  alias sui_tes_command_108 command_108
  def command_108
    sui_tes_command_108
    link_tes(@comments)
  end
  #--------------------------------------------------------------------------
  # ○ TESにリンク
  #--------------------------------------------------------------------------
  def link_tes(comments)
    comments.each do |comment|
      if comment =~ /<link\s+(\S+)(\s+(\S+))?>/
        begin
          list = TesManager.link($1)
          if list and list.size > 0
            tes = Game_Interpreter.new(@depth + 1)
            tes.setup(list, same_map? ? @event_id : 0)
            tes.link_label($3)
            tes.run
          end
        rescue TesLinkError => err
          text = err.message + "\n\tScenario -> #{$1}"
          text += ", Label -> *#{$3}" if $3
          msgbox(text)
          exit
        end
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ ラベルのある行にインデックスを設定
  #--------------------------------------------------------------------------
  def link_label(label)
    return unless label
    @list.size.times do |i|
      if @list[i].code == 118 and @list[i].parameters[0] == label
        @index = i
        return
      end
    end
    raise(TesLinkError, "リンク先のラベルは存在しませんでした。")
  end
end


#----------------------------------------------------------------------------
# ◇ TES管理
#----------------------------------------------------------------------------
module TesManager
  #--------------------------------------------------------------------------
  # ○ モジュールのインスタンス変数
  #--------------------------------------------------------------------------
  @tes = {}               # TES変換後のイベントコマンドリスト
  #--------------------------------------------------------------------------
  # ○ オブジェクト初期化
  #--------------------------------------------------------------------------
  def self.init
    @tes = load_tes(TES::MAIN_DIR, "main")
    patch if TES::PATCH_ENABLE
  end
  #--------------------------------------------------------------------------
  # ○ TESへのリンク
  #--------------------------------------------------------------------------
  def self.link(filename)
    unless @tes.include?(filename)
      raise(TesLinkError, "リンク先のシナリオは存在しませんでした。")
    end
    return @tes[filename]
  end
  private
  #--------------------------------------------------------------------------
  # ○ TESファイル読み込み
  #--------------------------------------------------------------------------
  def self.load_tes(dir, filename)
    begin
      if TES::WF_COMP_MODE
        name, events = load_tes_by_wf(dir, filename)
      else
        name, events = load_tes_by_tk(dir, filename)
      end
      unless x(name) == code + filename
        raise(TesLoadError)
      end
      return events
    rescue => err
      msgbox("TESの読み込みに失敗。\n\s\sFilename -> #{filename}")
      return {}
    end
  end
  #--------------------------------------------------------------------------
  # ○ TESファイル読み込み（標準アーカイブ）
  #--------------------------------------------------------------------------
  def self.load_tes_by_tk(dir, filename)
    temp = load_data(dir + filename + ".rvdata2")
    return Marshal.load(Zlib::Inflate.inflate(x(temp)))
  end
  #--------------------------------------------------------------------------
  # ○ TESファイル読み込み（WHITE-FLUTE版）
  #--------------------------------------------------------------------------
  def self.load_tes_by_wf(dir, filename)
    events = {}
    File.open(dir + filename + ".rvdata2", "rb") do |file|
      header   = Marshal.load(file)
      contents = Marshal.load(file)
      events = extract_save_contents(header, contents, filename)
    end
    return events
  end
  #--------------------------------------------------------------------------
  # ○ 標準アーカイブ用難読化
  #--------------------------------------------------------------------------
  def self.x(text)
    text  = text.unpack("C*")
    key   = keys.unpack("C*")
    index = 0
    while text.size > index
      k = text.size - index  > key.size ? key.size : text.size - index
      text[index, k] = text[index, k].zip(key[0, k]).collect{|a, b| a ^ b}
      index += k
    end
    text.pack("C*")
  end
  #--------------------------------------------------------------------------
  # ○ セーブ内容の展開
  #--------------------------------------------------------------------------
  def self.extract_save_contents(header, contents, filename)
    if filename == "main"
      index = 0
    else
      if filename =~ /^tespatch(\d+)$/
        index = $1.to_i
      else
        raise(TesLoadError)
      end
    end
    if header.checksum != Zlib.crc32(contents)
      raise(RuntimeError)
    end
    APISet.crypt_keys(8, 8, DataManager.xkeys_up(index)) do
      APISet.decrypt!(contents, header.iv)
    end
    contents = Zlib_xStreams.inflate(contents).force_encoding("ASCII-8BIT")
    xcrc = contents.slice!(0, 32)
    crc = Marshal.load(xcrc) 
    if crc != Zlib.crc32(contents)
      raise(RuntimeError)
    end
    return Marshal.load(contents)
  end
  #--------------------------------------------------------------------------
  # ○ パッチ処理
  #--------------------------------------------------------------------------
  def self.patch
    patches = []
    Dir.entries(TES::PATCH_DIR).each do |file|
      patches << $1.to_i if File.basename(file) =~ /^tespatch(\d+)\.rvdata2$/
    end
    patches.sort.each do |index|
      data = load_tes(TES::PATCH_DIR, "tespatch#{index.to_s}")
      if data
        data.each do |filename, events|
          @tes[filename] = events
        end
      end
    end
  end
end


if $TEST
class Scene_Map < Scene_Base
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  alias sui_tes_update update
  def update
    sui_tes_update
    if Input.press?(TES::CONVERT_MODE_BTN)
      SceneManager.call(Scene_TesConvertMode)
    end
  end
end


#----------------------------------------------------------------------------
# ◇ TES変換モード
#----------------------------------------------------------------------------
class Scene_TesConvertMode < Scene_MenuBase
  #--------------------------------------------------------------------------
  # ● 開始処理
  #--------------------------------------------------------------------------
  def start
    super
    create_top_window
    create_bottom_window
  end
  #--------------------------------------------------------------------------
  # ● 上ウィンドウの作成
  #--------------------------------------------------------------------------
  def create_top_window
    @top_window = Window_TesTop.new
    @top_window.set_handler(:ok,     method(:on_top_ok))
    @top_window.set_handler(:cancel, method(:return_scene))
  end
  #--------------------------------------------------------------------------
  # ● 下ウィンドウの作成
  #--------------------------------------------------------------------------
  def create_bottom_window
    @bottom_window = Window_TesBottom.new(@top_window.height + 20)
    @bottom_window.set_handler(:cancel, method(:on_bottom_cancel))
    @top_window.bottom_window = @bottom_window
  end
  #--------------------------------------------------------------------------
  # ● 上［決定］
  #--------------------------------------------------------------------------
  def on_top_ok
    @bottom_window.activate
    @bottom_window.select(0)
  end
  #--------------------------------------------------------------------------
  # ● 下［キャンセル］
  #--------------------------------------------------------------------------
  def on_bottom_cancel
    @top_window.activate
    @bottom_window.unselect
  end
  #--------------------------------------------------------------------------
  # ● 呼び出し元のシーンへ戻る
  #--------------------------------------------------------------------------
  def return_scene
    if @bottom_window.reload?
      TesManager.init
      print ("\n\n----- TES Reloaded --------------------\n")
    end
    super
  end
end


# パッチフォルダ群を表示
class Window_TesTop < Window_Selectable
  #--------------------------------------------------------------------------
  # ● クラス変数
  #--------------------------------------------------------------------------
  @@last_top_row = 0                      # 先頭の行 保存用
  @@last_index   = 0                      # カーソル位置 保存用
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_reader   :bottom_window             # 下ウィンドウ
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, Graphics.width, 72)
    refresh
    self.top_row = @@last_top_row
    select(@@last_index)
    activate
  end
  #--------------------------------------------------------------------------
  # ● 桁数の取得
  #--------------------------------------------------------------------------
  def col_max
    return 4
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    @bottom_window.target = @filelist[self.index] if @bottom_window
  end
  #--------------------------------------------------------------------------
  # ● 項目数の取得
  #--------------------------------------------------------------------------
  def item_max
    @filelist ? @filelist.size : 0
  end
  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    patches = []
    @filelist = []
    # フォルダのパッチ番号を抽出
    Dir.entries(TES::SOURCE_DIR).each do |dir|
      patches << $1.to_i if File.basename(dir) =~ /^tespatch(\d+)$/
    end
    # 数値でソートして代入
    patches.sort.each do |patch|
      @filelist << "tespatch#{patch}"
    end
    # メインを先頭に挿入
    @filelist.unshift("main")
    create_contents
    draw_all_items
  end
  #--------------------------------------------------------------------------
  # ● 項目の描画
  #--------------------------------------------------------------------------
  def draw_item(index)
    draw_text(item_rect_for_text(index), @filelist[index])
  end
  #--------------------------------------------------------------------------
  # ● キャンセルボタンが押されたときの処理
  #--------------------------------------------------------------------------
  def process_cancel
    super
    @@last_top_row = top_row
    @@last_index = index
  end
  #--------------------------------------------------------------------------
  # ○ 下ウィンドウの設定
  #--------------------------------------------------------------------------
  def bottom_window=(bottom_window)
    @bottom_window = bottom_window
    update
  end
end

# パッチフォルダ内の詳細を表示。
class Window_TesBottom < Window_Selectable
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(top_height)
    super(0, top_height, Graphics.width, Graphics.height - top_height)
    @target = nil
    @reload = false
    self.opacity = 0
    @update_info = TesManager.load_update_info
    create_caption
    refresh
  end
  #--------------------------------------------------------------------------
  # ● 終了処理
  #--------------------------------------------------------------------------
  def terminate
    super
    @caption.bitmap.dispose
    @caption.diopose
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    if Input.press?(:SHIFT) and Input.trigger?(:C)
      Sound.play_use_item
      TesManager.convert(@target)
      @update_info = TesManager.load_update_info
      refresh
      @reload = true
    end
  end
  #--------------------------------------------------------------------------
  # ○ キャプション作成
  #--------------------------------------------------------------------------
  def create_caption
    @caption = Sprite.new
    @caption.x = padding
    @caption.y = self.y - 10
    @caption.bitmap = Bitmap.new(contents_width, 15)
    @caption.bitmap.font.size = 16
    @caption.bitmap.font.color = system_color
    rect = @caption.bitmap.rect
    @caption.bitmap.draw_text(rect, "ファイル名")
    rect.x = 195
    @caption.bitmap.draw_text(rect, "アーカイブ内更新日時")
    rect.x = 365
    @caption.bitmap.draw_text(rect, "ソースフォルダ内更新日時")
  end
  #--------------------------------------------------------------------------
  # ● 項目数の取得
  #--------------------------------------------------------------------------
  def item_max
    @info_list ? @info_list.size : 0
  end
  #--------------------------------------------------------------------------
  # ○ ターゲットの指定
  #--------------------------------------------------------------------------
  def target=(value)
    if @target != value
      @target = value
      refresh
    end
  end
  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    return unless @target
    @info_list = []
    list = {}
    src = TES::SOURCE_DIR + @target + "/"
    # 更新情報からリスト作成
    if @update_info[@target]
      @update_info[@target].each do |filename, mtime|
        list[filename] = [mtime, nil]
      end
    end
    # フォルダからリスト作成
    Dir.entries(src, :encoding => "UTF-8").each do |file|
#~       if File.extname(src + file) == ".txt" and file != "replace.txt"
      if TesManager.extname(file) == ".txt" and file != "replace.txt"
        list[file] = [nil, nil] unless list.include?(file)
        list[file][1] = File.mtime(src + file)
      end
    end
    # リストを配列に変換
    list.each do |filename, mtimes|
      @info_list << [filename, mtimes[0], mtimes[1]]
    end
    create_contents
    contents.font.size = 20
    draw_all_items
  end
  #--------------------------------------------------------------------------
  # ● 項目の描画 
  #--------------------------------------------------------------------------
  def draw_item(index)
    info = @info_list[index]
    change_color(info[1] == info[2] ? normal_color : crisis_color)
    ctime = info[1] ? info[1].strftime("%Y.%m.%d %H:%M:%S") : "none"
    mtime = info[2] ? info[2].strftime("%Y.%m.%d %H:%M:%S") : "none"
    rect = item_rect_for_text(index)
    rect.width = 195
    draw_text(rect, info[0])
    rect.x = 195
    draw_text(rect, ctime)
    rect.x = 365
    draw_text(rect, mtime)
  end
  #--------------------------------------------------------------------------
  # ● TESのリロードが必要か？ 
  #--------------------------------------------------------------------------
  def reload?
    @reload
  end
end


#----------------------------------------------------------------------------
# ◇ TES管理
#----------------------------------------------------------------------------
module TesManager
  #--------------------------------------------------------------------------
  # ○ モジュールのインスタンス変数
  #--------------------------------------------------------------------------
  @output = []                  # 出力情報
  #--------------------------------------------------------------------------
  # ○ TES変換
  #--------------------------------------------------------------------------
  def self.convert(target)
    init_members
    dir = TES::SOURCE_DIR + target + "/"
    if TES::TES_LOCK.include?(target)
      output("!!!!! このシナリオフォルダはロックされています !!!!!")
      output("!!!!! 変換処理をキャンセルします。 !!!!!\n\n")
      save_output
      return
    end
    
    # 変換開始
    begin
      output("----- TES変換開始; Time : #{Time.now.to_s} -----")
      output("----- Target -> #{target}\n")
      Dir.entries(dir, :encoding => "UTF-8").each do |file|
        convert_file(dir, file)
      end
      raise(TesConvertError) if @error
      save_dir = target == "main" ? TES::MAIN_DIR : TES::PATCH_DIR
      save_tes(@events, save_dir, target)
      update_update_info(target)
      output("----- 変換が完了しました -----\n\n\n")
    rescue => err
      p err.message
      output("----- 変換に失敗しました -----\n\n\n")
    end
    save_output
  end
  #--------------------------------------------------------------------------
  # ○ 変換情報出力
  #--------------------------------------------------------------------------
  def self.output(text)
    @output << text
    print text + "\n"
  end
  #--------------------------------------------------------------------------
  # ○ アップデート情報読み込み
  #--------------------------------------------------------------------------
  def self.load_update_info
    begin
      filelist = load_data(TES::SOURCE_DIR + "update.rvdata2")
    rescue
      filelist = {}
    end
    return filelist
  end
  private
  #--------------------------------------------------------------------------
  # ○ メンバ変数の初期化
  #--------------------------------------------------------------------------
  def self.init_members
    @info   = {}
    @error  = false
    @output = []
    @events = {}
  end
  #--------------------------------------------------------------------------
  # ○ TES変換（ファイル単位）
  #--------------------------------------------------------------------------
  def self.convert_file(dir, file)
#~     return unless File.extname(dir + file) == ".txt"
    return unless extname(file) == ".txt"
    return if file == "replace.txt" # 置換リストは処理しない
    output("\n++++++++++ TesFile: #{file} ++++++++++\n")
    loader    = Tes_Loader.new
    splitter  = Tes_Splitter.new
    validator = Tes_Validator.new
    converter = Tes_Converter.new
    
    loader.run(dir, file)
    splitter.run(dir, loader.data) unless loader.error?
    validator.run(splitter.data)   unless splitter.error?
    converter.run(validator.data)  unless validator.error?
    unless converter.error?
      @events[File.basename(file, ".*")] = converter.data
      @info[file] = File.mtime(dir + file)
    else
      @error = true
    end
  end
  #--------------------------------------------------------------------------
  # ○ TESファイル書き込み
  #--------------------------------------------------------------------------
  def self.save_tes(events, dir, filename)
    begin
      name = x(code + filename)
      if TES::WF_COMP_MODE
        save_tes_by_wf(name, events, dir, filename)
      else
        save_tes_by_tk(name, events, dir, filename)
      end  
    rescue
      output("暗号化ファイルへの書き込みに失敗。\n\s\sFilename -> #{filename}")
      raise
    end
  end
  #--------------------------------------------------------------------------
  # ○ 拡張子の取得 
  #--------------------------------------------------------------------------
  def self.extname(file)
    return file[/\.\w+/i]
  end
  #--------------------------------------------------------------------------
  # ○ TESファイル書き込み（標準アーカイブ）
  #--------------------------------------------------------------------------
  def self.save_tes_by_tk(name, events, dir, filename)
    temp = Marshal.dump([name, events])
    temp = x(Zlib::Deflate.deflate(temp, Zlib::BEST_COMPRESSION))
    save_data(temp, dir + filename + ".rvdata2")
  end
  #--------------------------------------------------------------------------
  # ○ TESファイル書き込み（WHITE-FLUTE版）
  #--------------------------------------------------------------------------
  def self.save_tes_by_wf(name, events, dir, filename)
    File.open(dir + filename + ".rvdata2", "wb") do |file|
      contents, header = make_save_contents([name, events], filename)
      Marshal.dump(header, file)
      Marshal.dump(contents, file)
    end
  end
  #--------------------------------------------------------------------------
  # ○ セーブ内容の作成
  #--------------------------------------------------------------------------
  def self.make_save_contents(contents, filename)
    if filename == "main"
      index = 0
    else
      if filename =~ /^tespatch(\d+)$/
        index = $1.to_i
      else
        raise(TesSaveError)
      end
    end
    contents = Marshal.dump(contents)
    xcrc = DataManager.make_crc32_internal(contents)
    contents = xcrc + contents
    compstr = Zlib_xStreams.deflate(contents)
    header = Game_SaveComp.new
    APISet.crypt_keys(8, 8, DataManager.xkeys_up(index)) do
      APISet.encrypt!(compstr, header.iv)
    end
    header.checksum =  Zlib.crc32(compstr)
    [compstr, header]
  end
  #--------------------------------------------------------------------------
  # ○ アップデート情報読み込み
  #--------------------------------------------------------------------------
  def self.load_update_info
    begin
      filelist = load_data(TES::SOURCE_DIR + "update.rvdata2")
    rescue
      filelist = {}
    end
    return filelist
  end
  #--------------------------------------------------------------------------
  # ○ アップデート情報書き込み
  #--------------------------------------------------------------------------
  def self.save_update_info(info)
    begin
      save_data(info, TES::SOURCE_DIR + "update.rvdata2")
    rescue
      output("アップデート情報の書き込みに失敗しました。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ アップデート情報更新
  #--------------------------------------------------------------------------
  def self.update_update_info(target)
    update_info = load_update_info
    update_info[target] = @info
    save_update_info(update_info)
  end
  #--------------------------------------------------------------------------
  # ○ 変換情報テキストへ出力
  #--------------------------------------------------------------------------
  def self.save_output
    begin
      unless FileTest.exist?(TES::SOURCE_DIR + "tes_output.txt")
        File.open(TES::SOURCE_DIR + "tes_output.txt", "w") {}
      end
      File.open(TES::SOURCE_DIR + "tes_output.txt", "r+") { |f|
        old = f.read
        f.pos = 0
        @output.each do |text|
          f.write(text + "\n")
        end
        f.write(old)
      }
    rescue
      msgbox("変換情報の出力に失敗しました。")
    end
  end
end


#----------------------------------------------------------------------------
# ◇ TES変換
#----------------------------------------------------------------------------
class Tes_ConverterBase
  #--------------------------------------------------------------------------
  # ○ オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    @error = false
    @data  = []
  end
  #--------------------------------------------------------------------------
  # ○ 処理開始
  #--------------------------------------------------------------------------
  def run
    pre_processing
    processing
    post_processing
  end
  #--------------------------------------------------------------------------
  # ○ 前処理
  #--------------------------------------------------------------------------
  def pre_processing
  end
  #--------------------------------------------------------------------------
  # ○ メイン処理
  #--------------------------------------------------------------------------
  def processing
  end
  #--------------------------------------------------------------------------
  # ○ 後処理
  #--------------------------------------------------------------------------
  def post_processing
    @data.clear if error?
  end
  #--------------------------------------------------------------------------
  # ○ データ取得
  #--------------------------------------------------------------------------
  def data
    return @data
  end
  #--------------------------------------------------------------------------
  # ○ エラーフラグ
  #--------------------------------------------------------------------------
  def error?
    return (@data.empty? or @error)
  end
  #--------------------------------------------------------------------------
  # ○ 行数取得
  #--------------------------------------------------------------------------
  def line_number
    0
  end
  #--------------------------------------------------------------------------
  # ○ エラーメッセージの出力
  #--------------------------------------------------------------------------
  def err_message(err)
    @error = true
    message = "line " + sprintf("%04d",line_number) + " : #{err.message}"
    TesManager.output(message)
  end
end

class Tes_Loader < Tes_ConverterBase
  #--------------------------------------------------------------------------
  # ○ オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    super
    @line_number = 0
  end
  #--------------------------------------------------------------------------
  # ○ 処理開始
  #--------------------------------------------------------------------------
  def run(dir, filename)
    @dir = dir
    @filename = filename
    TesManager.output(">TESの読み込みを開始")
    begin
      super()
    rescue => err
      @error = true
      @data.clear
      TesManager.output("#{err.message}")
      TesManager.output(">>TESの読み込みに失敗")
    end
    TesManager.output(">>>TESの読み込み処理が終了\n")
  end
  #--------------------------------------------------------------------------
  # ○ メイン処理
  #--------------------------------------------------------------------------
  def processing
    super
    File.open(@dir + @filename, "r", :encoding => "BOM|UTF-8") do |f|
      f.each_line do |line|
        @line_number += 1
        line.gsub!(/\r\n|\r|\n/) { "" }
        @data << [line, @line_number]
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ 後処理
  #--------------------------------------------------------------------------
  def post_processing
    super
    if @data.empty?
      raise(TesLoadError, "\n>>変換できるシナリオがありませんでした")
    end
  end
  #--------------------------------------------------------------------------
  # ○ 行数取得
  #--------------------------------------------------------------------------
  def line_number
    @line_number
  end
end

class Tes_Splitter < Tes_ConverterBase
  #--------------------------------------------------------------------------
  # ○ オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    super
    @index = 0
    @replace_list = []
  end
  #--------------------------------------------------------------------------
  # ○ 処理開始
  #--------------------------------------------------------------------------
  def run(dir, lines)
    @dir   = dir
    @lines = lines
    TesManager.output(">TESのコマンド分割を開始")
    begin
      super()
    rescue => err
      @error = true
      @data.clear
      TesManager.output("#{err.message}")
      TesManager.output(">>TESのコマンド分割に失敗")
    end
    TesManager.output(">>>TESのコマンド分割処理が完了\n")
  end
  #--------------------------------------------------------------------------
  # ○ 前処理
  #--------------------------------------------------------------------------
  def pre_processing
    super
    @replace_list.clear
    return unless FileTest.exist?(@dir + "replace.txt")
    File.open(@dir + "replace.txt", "r", :encoding => "BOM|UTF-8") do |f|
      f.each_line do |line|
        line.gsub!(/\r\n|\r|\n/) { "" }
        before, after = line.split(/\t+/, 2)
        @replace_list << [before, after] if !before.empty? and !after.empty?
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ メイン処理
  #--------------------------------------------------------------------------
  def processing
    until eoc?
      begin
        allocate
      rescue TesSyntaxError => err
        err_message(err)
      ensure
        @index += 1
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ 後処理
  #--------------------------------------------------------------------------
  def post_processing
    super
    if @data.empty?
      raise(TesSplitError, "\n>>TESコマンドが検出されませんでした")
    end
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理の振り分け
  #--------------------------------------------------------------------------
  def allocate
    text = get_line
    return if text.empty?             # 空行は飛ばす
    first = get_first_character(text)
    if first == "*"                   # ラベル分割
      split_label2
    elsif first == "@"                # タグ分割
      tag = get_command_name(text)
      if respond_to?("split_#{tag}")  # 専用分割コマンドがある場合は処理
        send("split_#{tag}")
      else
        split_normal                  # 一般タグの分割処理
      end
    else
      split_message                   # それ以外はメッセージ行分割処理
    end
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理（メッセージ）
  #--------------------------------------------------------------------------
  def split_message
    if @data.empty? or @data[-1][0] != "message_h"
      @data << ["message_h", {}, line_number] # デフォルト値ヘッダー設定
    end
    messages = []
    until eoc?
      temp = replace_message(get_line)
      messages << ["message", {"value" => temp}, line_number]
      break if messages.size >= 4 or !next_message?  # 最大４行
      @index += 1
    end
    @data += messages
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理（ラベル）
  #--------------------------------------------------------------------------
  def split_label2
    label = get_line[1, 9999].strip
    if label.empty?
      raise(TesSyntaxError, "ラベルが無名です。")
    end
    @data << ["label", {"value" => label}, line_number]
  end
  #--------------------------------------------------------------------------
  # ○ 分割処理（一般タグ）
  #--------------------------------------------------------------------------
  def split_normal
    text = get_line
    tag  = get_command_name(text)
    args = get_command_args(text)
    @data << [tag, args, line_number]
  end
  #--------------------------------------------------------------------------
  # ○ 行数取得
  #--------------------------------------------------------------------------
  def line_number
    eoc? ? -1 : @lines[@index][1]
  end
  #--------------------------------------------------------------------------
  # ○ コマンドの終端か？
  #--------------------------------------------------------------------------
  def eoc?
    return @index >= @lines.size
  end
  #--------------------------------------------------------------------------
  # ○ コメントと前後空白の削除
  #--------------------------------------------------------------------------
  def erace_comment(line)
    return line ? line.gsub(/#.*/) { "" }.strip : ""
  end
  #--------------------------------------------------------------------------
  # ○ カレント行文字列取得
  #--------------------------------------------------------------------------
  def get_line
    return erace_comment(@lines[@index][0])
  end
  #--------------------------------------------------------------------------
  # ○ 次の行文字列取得
  #--------------------------------------------------------------------------
  def get_next_line
    return "" if @index + 1 >= @lines.size
    return erace_comment(@lines[@index + 1][0])
  end
  #--------------------------------------------------------------------------
  # ○ １文字目取得
  #--------------------------------------------------------------------------
  def get_first_character(text)
    return text.lstrip[0, 1]
  end
  #--------------------------------------------------------------------------
  # ○ コマンド名取得
  #--------------------------------------------------------------------------
  def get_command_name(text)
    if get_first_character(text) == "@"
      return text.slice(/^\S+/)[1, 9999].strip.downcase
    else
      return nil
    end
  end
  #--------------------------------------------------------------------------
  # ○ コマンドの引数部を取得
  #--------------------------------------------------------------------------
  def get_command_args(text)
    temp = {}
    if cmd = get_command_name(text)
      if args = text[cmd.size + 1, 9999].strip
        args.gsub!(/\s*=\s*/) { "<=>" }
        args.split(/\s+/).each do |arg|
          key, param = arg.split("<=>", 2)
          temp[key.downcase] = param
        end
      end
    end
    return temp
  end
  #--------------------------------------------------------------------------
  # ○ 次の行がメッセージか？
  #--------------------------------------------------------------------------
  def next_message?
    text = get_next_line
    return false if text.empty?                 # 空行はfalse
    first = get_first_character(text)
    return !(first == "*" or first == "@")      # 特殊文字行がきたらfalse
  end
  #--------------------------------------------------------------------------
  # ○ メッセージの置換処理
  #--------------------------------------------------------------------------
  def replace_message(text)
    @replace_list.each do |before, after|
      text.gsub!(/#{before}/) { after }
    end
    return text
  end
end

class Tes_Validator < Tes_ConverterBase
  #--------------------------------------------------------------------------
  # ○ クラス変数
  #--------------------------------------------------------------------------
  @@validates = {}
  #--------------------------------------------------------------------------
  # ○ オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    super
    @index = 0
  end
  #--------------------------------------------------------------------------
  # ○ 処理開始
  #--------------------------------------------------------------------------
  def run(data)
    @data = data
    TesManager.output(">TESのコマンド検証を開始")
    begin
      super()
    rescue => err
      @error = true
      @data.clear
      TesManager.output("#{err.message}")
      TesManager.output(">>TESのコマンド検証に失敗")
    end
    TesManager.output(">>>TESのコマンド検証処理が完了\n")
  end
  #--------------------------------------------------------------------------
  # ○ メイン処理
  #--------------------------------------------------------------------------
  def processing
    until eoc?
      begin
        validation
      rescue TesValidateError => err
        err_message(err)
      ensure
        @index += 1
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ 後処理
  #--------------------------------------------------------------------------
  def post_processing
    super
    if @data.empty?
      raise(TesValidateError, "\n>>TESコマンドの検証で問題が見つかりました")
    end
  end
  #--------------------------------------------------------------------------
  # ○ コマンドの検証
  #--------------------------------------------------------------------------
  def validation
    command   = get_command_name
    args      = get_command_args
    validates = get_validate_funcs(command)
    validates.each do |param_name, funcs|
      funcs.each do |func, vargs|
        begin
          validate_func_exists?(func)
          send("validate_#{func}", vargs, param_name, args)
        rescue TesValidateError => err
          err_message(err)
        end
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ 検証コマンドの存在確認
  #--------------------------------------------------------------------------
  def validate_func_exists?(func)
    unless respond_to?("validate_#{func}")
      raise(TesValidateError,
        "検証コマンド「validate_#{func}」がありません。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ バリデーションの取得
  #--------------------------------------------------------------------------
  def get_validate_funcs(tag)
    return (@@validates[tag] or {})
  end
  #--------------------------------------------------------------------------
  # ○ コマンド名の取得
  #--------------------------------------------------------------------------
  def get_command_name
    @data[@index][0]
  end
  #--------------------------------------------------------------------------
  # ○ コマンド名の取得
  #--------------------------------------------------------------------------
  def get_command_args
    @data[@index][1]
  end
  #--------------------------------------------------------------------------
  # ○ 行数取得
  #--------------------------------------------------------------------------
  def line_number
    @data[@index][2]
  end
  #--------------------------------------------------------------------------
  # ○ コマンドの終端か？
  #--------------------------------------------------------------------------
  def eoc?
    return @index >= @data.size
  end
end

class Tes_Converter < Tes_ConverterBase
  #--------------------------------------------------------------------------
  # ○ オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    super
    @index  = 0
    @indent = 0
  end
  #--------------------------------------------------------------------------
  # ○ 処理開始
  #--------------------------------------------------------------------------
  def run(commands)
    @commands = commands
    TesManager.output(">ツクールイベントへの変換を開始")
    begin
      super()
    rescue => err
      @error = true
      @data.clear
      TesManager.output("#{err.message}")
      TesManager.output(">>ツクールイベントへの変換に失敗")
    end
    TesManager.output(">>>ツクールイベントへの変換処理が完了\n")
  end
  #--------------------------------------------------------------------------
  # ○ メイン処理
  #--------------------------------------------------------------------------
  def processing
    until eoc?
      begin
        convert
      rescue TesConvertError => err
        err_message(err)
      ensure
        @index += 1
      end
    end
  end
  #--------------------------------------------------------------------------
  # ○ 後処理
  #--------------------------------------------------------------------------
  def post_processing
    super
    if @data.empty?
      raise(TesConvertError, "\n>>変換されたイベントがありませんでした")
    else
      @data << RPG::EventCommand.new
    end
  end
  #--------------------------------------------------------------------------
  # ○ コマンドの変換
  #--------------------------------------------------------------------------
  def convert
    command   = get_command_name
    args      = get_command_args
    convert_func_exists?(command)
    temp = send("convert_#{command}", args)
    @data << temp if temp
  end
  #--------------------------------------------------------------------------
  # ○ 変換コマンドの存在確認
  #--------------------------------------------------------------------------
  def convert_func_exists?(func)
    unless respond_to?("convert_#{func}")
      raise(TesConvertError,
        "変換コマンド「convert_#{func}」がありません。")
    end
  end
  #--------------------------------------------------------------------------
  # ○ コマンド名の取得
  #--------------------------------------------------------------------------
  def get_command_name
    @commands[@index][0]
  end
  #--------------------------------------------------------------------------
  # ○ コマンド名の取得
  #--------------------------------------------------------------------------
  def get_command_args
    @commands[@index][1]
  end
  #--------------------------------------------------------------------------
  # ○ 行数取得
  #--------------------------------------------------------------------------
  def line_number
    @commands[@index][2]
  end
  #--------------------------------------------------------------------------
  # ○ コマンドの終端か？
  #--------------------------------------------------------------------------
  def eoc?
    return @index >= @commands.size
  end
end
end
