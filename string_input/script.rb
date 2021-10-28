#******************************************************************************
#   ＊ 文字入力の処理 ＊
#                       for RGSS3
#        Ver 1.01   2015.02.08
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    機能
      イベントコマンド「数値入力の処理」に相当する文字版を実装します。
      数値入力の処理コマンド同様、「文章の表示」コマンドの直後に指定すれば、
      メッセージ枠を表示したまま文字入力の処理を表示することが可能です。

    使い方
  　　注釈に制御タグを記述して起動します。
  
  　　１．選択式
  　　　　<schoice variable_id text>
           variable_id : 結果を保存するゲーム変数のIDを指定します。
           text        : 文字入力の正答を記述します。
           
      ２．リール式
  　　　　<sreel variable_id text> または、
  　　　　<sreel variable_id reel_speed text>
           variable_id : 結果を保存するゲーム変数のIDを指定します。
           text        : 文字入力の正答を記述します。
           reel_speed  : リールの回転スピードを指定します。
           　　　　　　  1 が一番早く、数字が増えるほどに遅くなります。
           
      ３．スロット式
  　　　　<sslot variable_id text> または、
  　　　　<sslot variable_id reel_speed text>
           variable_id : 結果を保存するゲーム変数のIDを指定します。
           text        : 文字入力の正答を記述します。
           reel_speed  : リールの回転スピードを指定します。
           　　　　　 　 1 が一番早く、数字が増えるほどに遅くなります。

      　　 ※variable_idで指定した変数には以下の値が保存されます。
      　　　 条件分岐等で処理を振り分けてください。
             キャンセル時：-1
             正解時　　　：1
             不正解時　　：0

    お邪魔文字について
    　通常は正答テキストだけをシャッフルして選択するようになっています。
    　しかし、正答以外の文字も追加して難易度をあげたい場合、
    　注釈の２行目にテキストを記述することで更に選択肢を増やすことができます。
    
    使用できる制御文字について
    　正答テキスト、お邪魔文字については「文章の表示」コマンド同様、
    　制御文字を使用することができます。
  　　使用できる制御文字は以下のとおりです。
  　　\V[n]  \N[n]  \P[n]  \G  \I[n]
      ※制御文字拡張素材により拡張される場合があります。
=end

#==============================================================================
# コンフィグ項目
#==============================================================================
module SUI
module STRINPUT
  # スロットのリールを止めるときのＳＥ
  SLOT_SE = RPG::SE.new("Equip1", 100, 130)
  
  # 回転リールのデフォルト速度
  DEFAULT_REEL_SPEED = 5
  
  # スロットの回転方向（8 で正転、 2 で逆転）
  SLOT_DIRECTION = 2
end
end
#==============================================================================
# 設定完了
#==============================================================================


class Game_Message
  attr_accessor :sui_sinput_type           # 文字入力のタイプ
  attr_accessor :sui_sinput_text           # 文字入力用テキスト
  attr_accessor :sui_sinput_add_text       # お邪魔文字用テキスト
  attr_accessor :sui_sinput_variable_id    # 文字入力正否フラグ用変数
  attr_accessor :sui_sinput_reel_speed     # リールの回転スピード
  #--------------------------------------------------------------------------
  # ○ 文字入力モード判定
  #--------------------------------------------------------------------------
  def sui_sinput?
    return false unless @sui_sinput_text
    !@sui_sinput_text.empty?
  end
  #--------------------------------------------------------------------------
  # ● クリア
  #--------------------------------------------------------------------------
  alias sui_sinput_clear clear
  def clear
    sui_sinput_clear
    @sui_sinput_type        = ""
    @sui_sinput_text        = ""
    @sui_sinput_add_text    = ""
    @sui_sinput_variable_id = 0
    @sui_sinput_reel_speed  = 0
  end
  #--------------------------------------------------------------------------
  # ● ビジー判定
  #--------------------------------------------------------------------------
  alias sui_sinput_busy? busy?
  def busy?
    sui_sinput_busy? || sui_sinput?
  end
end


class Game_Interpreter
  #--------------------------------------------------------------------------
  # ○ 注釈が文字入力タグとして使用されているか？
  #    選択式　　：<schoice variable text>
  #    リール式　：<sreel variable speed text>
  #    スロット式：<sslot variable speed text>
  #--------------------------------------------------------------------------
  def sui_sinput?(param)
    if param[0] =~ /<schoice|sreel|sslot\s+\d+(\s+(\d+))?\s+.+?>/
      return @sui_sinput = true
    end
    return false
  end
  #--------------------------------------------------------------------------
  # ● 次のイベントコマンドのコードを取得
  #--------------------------------------------------------------------------
  alias sui_sinput_next_event_code next_event_code
  def next_event_code
    code = sui_sinput_next_event_code
    code = 103 if code == 108 && sui_sinput?(@list[@index + 1].parameters)
    code
  end
  #--------------------------------------------------------------------------
  # ● 注釈
  #--------------------------------------------------------------------------
  alias sui_sinput_command_108 command_108
  def command_108
    if sui_sinput?(@params)
      setup_num_input(@params)
      Fiber.yield while $game_message.sui_sinput?
    end
    sui_sinput_command_108
  end
  #--------------------------------------------------------------------------
  # ● 数値入力のセットアップ
  #--------------------------------------------------------------------------
  alias sui_sinput_setup_num_input setup_num_input
  def setup_num_input(params)
    if @sui_sinput
      sui_sinput_setup(params)
    else
      sui_sinput_setup_num_input(params)
    end
    @sui_sinput = false
  end
  #--------------------------------------------------------------------------
  # ○ 文字入力のセットアップ
  #--------------------------------------------------------------------------
  def sui_sinput_setup(params)
    if params[0] =~ /<(schoice|sreel|sslot)\s+(\d+)(\s+(\d+))?\s+(.+?)>/
      $game_message.sui_sinput_type = $1
      $game_message.sui_sinput_variable_id = $2.to_i
      $game_message.sui_sinput_text        = $5
      $game_message.sui_sinput_reel_speed  = $4.to_i if $3
    end
    if @list[@index + 1].code == 408
      $game_message.sui_sinput_add_text = @list[@index + 1].parameters[0]
    end
  end
end


class Sprite_Reel < Bitmap
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_accessor :dest_rect               # 転送先矩形
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(target, words)
    @target = target
    @words = [words[-1]] + words + [words[0]]
    @speed = $game_message.sui_sinput_reel_speed
    @speed = SUI::STRINPUT::DEFAULT_REEL_SPEED if @speed == 0
    @add_value = @target.line_height.to_f / @speed
    @duration = 0
    @dest_rect = Rect.new
    super(@target.word_width, @words.size * @target.line_height)
    create_bitmap
    create_src_rect
  end
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  def dispose
    super
    @target = nil
  end
  #--------------------------------------------------------------------------
  # ○ ビットマップの作成
  #--------------------------------------------------------------------------
  def create_bitmap
    rect = Rect.new(0, 0, @target.word_width, @target.line_height)
    @words.each do |c|
      if c =~/^\eI\[(\d+)\]/
        draw_icon($1.to_i, rect)
      else
        draw_text(rect, c, 1)
      end
      rect.y += @target.line_height
    end
  end
  #--------------------------------------------------------------------------
  # ○ アイコンの描画
  #--------------------------------------------------------------------------
  def draw_icon(icon_index, rect)
    bitmap = Cache.system("Iconset")
    offset = (@target.word_width - 24) / 2
    src_rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
    self.blt(rect.x + offset, rect.y, bitmap, src_rect)
  end
  #--------------------------------------------------------------------------
  # ○ 転送元矩形の作成
  #--------------------------------------------------------------------------
  def create_src_rect
    @src_rect = Rect.new
    @src_rect.x = 0
    @src_rect.y = @target.line_height / 2
    @src_rect.width = @target.word_width
    @src_rect.height = @target.line_height * 2
    @rect_y = @src_rect.y.to_f
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    return unless rotation?
    @rect_y = (@rect_y + @add_value) % ((@words.size - 2) * @target.line_height)
    @duration -= 1
    @rect_y = @rect_y.round.to_f if @duration % @speed == 0
    @src_rect.y = @rect_y.to_i
    draw_reel
  end
  #--------------------------------------------------------------------------
  # ○ リールの描画
  #--------------------------------------------------------------------------
  def draw_reel
    @target.contents.clear_rect(@dest_rect)
    @target.contents.stretch_blt(@dest_rect, self, @src_rect)
  end
  #--------------------------------------------------------------------------
  # ○ 回転の開始
  #    dir : 8 で正転、 2 で逆転
  #    loop : true でノンストップ
  #--------------------------------------------------------------------------
  def start(dir, loop = false)
    @duration += @speed
    @duration = -@speed if loop
    @add_value = @add_value.abs * ((dir == 2) ? -1.0 : 1.0)
  end
  #--------------------------------------------------------------------------
  # ○ 回転の停止
  #--------------------------------------------------------------------------
  def stop
    @duration = @duration % @speed
  end
  #--------------------------------------------------------------------------
  # ○ 回転中か？
  #--------------------------------------------------------------------------
  def rotation?
    @duration > 0 || @duration < 0
  end
  #--------------------------------------------------------------------------
  # ○ 現在のインデックス
  #--------------------------------------------------------------------------
  def index
    ((@rect_y.round - 12) / @target.line_height) % @words.size
  end
end


class Window_SuiStringInputBase < Window_Base
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(message_window)
    @message_window = message_window
    super(0, 0, 0, 0)
    self.openness = 0
    create_words($game_message.sui_sinput_text)
    additon_words($game_message.sui_sinput_add_text)
    @words.shuffle!.shuffle!.shuffle!
    start
  end
  #--------------------------------------------------------------------------
  # ○ 文字入力の開始
  #--------------------------------------------------------------------------
  def start
    @index = 0
    @selected = []
    update_placement
    create_contents
    refresh
    open
    activate
  end
  #--------------------------------------------------------------------------
  # ○ ウィンドウ位置の更新
  #--------------------------------------------------------------------------
  def update_placement
    self.width = size_x * word_width + padding * 4
    self.height = fitting_height(size_y)
    self.x = (Graphics.width - width) / 2
    if @message_window.y >= Graphics.height / 2
      self.y = @message_window.y - height - 8
    else
      self.y = @message_window.y + @message_window.height + 8
    end
  end
  #--------------------------------------------------------------------------
  # ○ 横サイズ
  #--------------------------------------------------------------------------
  def size_x
    @original_size
  end
  #--------------------------------------------------------------------------
  # ○ 縦サイズ
  #--------------------------------------------------------------------------
  def size_y
    3
  end
  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    change_color(normal_color)
  end
  #--------------------------------------------------------------------------
  # ○ 文字の配列を作成
  #--------------------------------------------------------------------------
  def create_words(text)
    @words = []
    cnt = 0
    text = convert_escape_characters(text)
    while cnt < text.length
      @words << text[cnt, 1]
      @words[-1] += text.slice!(/(I\[\d+\])/) if text[cnt, 1] == "\e"
      cnt += 1
    end
    @correct_answer = @words.join
    @original_size = @words.size
  end
  #--------------------------------------------------------------------------
  # ○ 追加ワードの配列
  #--------------------------------------------------------------------------
  def additon_words(text)
    return if text.empty?
    cnt = 0
    text = convert_escape_characters(text)
    while cnt < text.length
      @words << text[cnt, 1]
      @words[-1] += text.slice!(/(I\[\d+\])/) if text[cnt, 1] == "\e"
      cnt += 1
    end
  end
  #--------------------------------------------------------------------------
  # ○ １文字の幅
  #--------------------------------------------------------------------------
  def word_width
    30
  end
  #--------------------------------------------------------------------------
  # ○ 文字の描画
  #--------------------------------------------------------------------------
  def draw_word(c, rect)
    if c =~ /^\eI\[(\d+)\]/
      offset = (word_width - 24) / 2
      draw_icon($1.to_i, rect.x + offset, rect.y)
    else
      draw_text(rect, c, 1)
    end
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    return unless active
    process_cursor_move
    return process_ok     if Input.trigger?(:C)
    return process_cancel if Input.trigger?(:B)
    update_cursor
  end
  #--------------------------------------------------------------------------
  # ● カーソルの移動処理
  #--------------------------------------------------------------------------
  def process_cursor_move
    last_index = @index
    cursor_right(Input.trigger?(:RIGHT)) if Input.repeat?(:RIGHT)
    cursor_left (Input.trigger?(:LEFT))  if Input.repeat?(:LEFT)
    Sound.play_cursor if @index != last_index
  end
  #--------------------------------------------------------------------------
  # ● カーソルを右に移動
  #     wrap : ラップアラウンド許可
  #--------------------------------------------------------------------------
  def cursor_right(wrap)
    @index = (@index + 1) % size_x if @index < size_x - 1 || wrap
  end
  #--------------------------------------------------------------------------
  # ● カーソルを左に移動
  #     wrap : ラップアラウンド許可
  #--------------------------------------------------------------------------
  def cursor_left(wrap)
    @index = (@index - 1) % size_x if @index > 0 || wrap
  end
  #--------------------------------------------------------------------------
  # ● 項目を描画する矩形の取得
  #--------------------------------------------------------------------------
  def item_rect(index)
    rect = Rect.new
    rect.x = word_width * index + padding
    rect.width = word_width
    rect.height = line_height + 4
    rect
  end
  #--------------------------------------------------------------------------
  # ○ 入力完了
  #--------------------------------------------------------------------------
  def input_complete
    Sound.play_ok
    flag = @correct_answer == user_answer
    $game_variables[$game_message.sui_sinput_variable_id] = flag ? 1 : 0
    deactivate
    close
  end
  #--------------------------------------------------------------------------
  # ○ 完成した文字列の取得
  #--------------------------------------------------------------------------
  def user_answer
    @selected.inject("") {|r, i| r += @words[i] }
  end
  #--------------------------------------------------------------------------
  # ● 決定ボタンが押されたときの処理
  #--------------------------------------------------------------------------
  def process_ok
  end
  #--------------------------------------------------------------------------
  # ● キャンセルボタンが押されたときの処理
  #--------------------------------------------------------------------------
  def process_cancel
    Sound.play_cancel
    $game_variables[$game_message.sui_sinput_variable_id] = -1
    deactivate
    close
  end
  #--------------------------------------------------------------------------
  # ○ すべて入力済みか？
  #--------------------------------------------------------------------------
  def full?
    @selected.size == @original_size
  end
  #--------------------------------------------------------------------------
  # ● カーソルの更新
  #--------------------------------------------------------------------------
  def update_cursor
    if full?
      cursor_rect.set(0, 0, contents.width, contents.height)
    else
      cursor_rect.set(item_rect(@index))
    end
  end
end


class Window_SuiStringInputChoice < Window_SuiStringInputBase
  #--------------------------------------------------------------------------
  # ○ 入力処理の開始
  #--------------------------------------------------------------------------
  def start
    update_placement
    create_answer_area_rect
    create_word_area_rect
    super
  end
  #--------------------------------------------------------------------------
  # ○ 横サイズ
  #--------------------------------------------------------------------------
  def size_x
    @words.size
  end
  #--------------------------------------------------------------------------
  # ○ 解答エリアの矩形作成
  #--------------------------------------------------------------------------
  def create_answer_area_rect
    @answer_rect = Rect.new
    @answer_rect.y = line_height * 0.4
    @answer_rect.width = @original_size * word_width
    @answer_rect.x = (contents_width - @answer_rect.width) / 2
    @answer_rect.height = line_height
  end
  #--------------------------------------------------------------------------
  # ○ 文字エリアの矩形作成
  #--------------------------------------------------------------------------
  def create_word_area_rect
    @word_rect = Rect.new
    @word_rect.x = padding
    @word_rect.y = line_height * 1.8
    @word_rect.width = @words.size * word_width
    @word_rect.height = line_height
  end
  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    super
    draw_underline
    draw_answer_area
    draw_word_area
  end
  #--------------------------------------------------------------------------
  # ○ 下線の描画
  #--------------------------------------------------------------------------
  def draw_underline
    span = 6
    rect = Rect.new(0, line_height * 1.4, word_width - span, 1)
    @original_size.times do |i|
      rect.x = @answer_rect.x + word_width * i + span / 2
      contents.fill_rect(rect, normal_color)
    end
  end
  #--------------------------------------------------------------------------
  # ○ 解答エリアの再描画
  #--------------------------------------------------------------------------
  def draw_answer_area
    rect = @answer_rect.clone
    rect.width = word_width
    @selected.each do |i|
      draw_word(@words[i], rect)
      rect.x += word_width
    end
  end
  #--------------------------------------------------------------------------
  # ○ 文字エリアの再描画
  #--------------------------------------------------------------------------
  def draw_word_area
    rect = @word_rect.clone
    rect.width = word_width
    @words.each_with_index do |c, i|
      draw_word(c, rect) unless @selected.include?(i)
      rect.x += word_width
    end
  end
  #--------------------------------------------------------------------------
  # ● 項目を描画する矩形の取得
  #--------------------------------------------------------------------------
  def item_rect(index)
    rect = super
    rect.y = line_height * 1.8 - 2
    rect
  end
  #--------------------------------------------------------------------------
  # ● 決定ボタンが押されたときの処理
  #--------------------------------------------------------------------------
  def process_ok
    return input_complete if full?
    if @selected.include?(@index)
      Sound.play_buzzer
    else
      Sound.play_ok
      @selected << @index
      refresh
    end
  end
  #--------------------------------------------------------------------------
  # ● キャンセルボタンが押されたときの処理
  #--------------------------------------------------------------------------
  def process_cancel
    return super if @selected.size == 0
    Sound.play_cancel
    @selected.pop
    refresh
  end
end


class Window_SuiStringInputReel < Window_SuiStringInputBase
  #--------------------------------------------------------------------------
  # ○ 縦サイズ
  #--------------------------------------------------------------------------
  def size_y
    2
  end
  #--------------------------------------------------------------------------
  # ○ スロットモードか？
  #--------------------------------------------------------------------------
  def slot?
    false
  end
  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    super
    @reels.each {|reel| reel.dispose } if @reels
    @reels ||= []
    @reels.clear
    rect = Rect.new(padding, 0, word_width, line_height * 2)
    rect.y = (contents.height - rect.height) / 2
    size_x.times do
      @reels << Sprite_Reel.new(self, @words)
      @reels[-1].dest_rect = rect.clone
      @reels[-1].draw_reel
      @reels[-1].start(SUI::STRINPUT::SLOT_DIRECTION, true) if slot?
      rect.x += word_width
    end
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    return unless active
    @reels.each {|reel| reel.update } if @reels
  end
  #--------------------------------------------------------------------------
  # ● カーソルの移動処理
  #--------------------------------------------------------------------------
  def process_cursor_move
    super
    last_rotation = @reels[@index].rotation?
    cursor_up if Input.repeat?(:UP)
    cursor_down if Input.repeat?(:DOWN)
    Sound.play_cursor if last_rotation != @reels[@index].rotation?
  end
  #--------------------------------------------------------------------------
  # ● 項目を描画する矩形の取得
  #--------------------------------------------------------------------------
  def item_rect(index)
    rect = super
    rect.y = (contents.height - line_height) / 2 - 2
    rect
  end
  #--------------------------------------------------------------------------
  # ● カーソルを上に移動
  #--------------------------------------------------------------------------
  def cursor_up
    @reels[@index].start(8) unless @reels[@index].rotation?
  end
  #--------------------------------------------------------------------------
  # ● カーソルを下に移動
  #--------------------------------------------------------------------------
  def cursor_down
    @reels[@index].start(2) unless @reels[@index].rotation?
  end
  #--------------------------------------------------------------------------
  # ● 決定ボタンが押されたときの処理
  #--------------------------------------------------------------------------
  def process_ok
    if @reels.any? {|reel| reel.rotation? }
      Sound.play_buzzer
    else
      @selected = []
      @reels.each {|reel| @selected << reel.index}
      input_complete
    end
  end
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  def dispose
    @reels.each {|reel| reel.dispose} if @reels
    super
  end
end


class Window_SuiStringInputSlot < Window_SuiStringInputReel
  #--------------------------------------------------------------------------
  # ● 項目を描画する矩形の取得
  #--------------------------------------------------------------------------
  def item_rect(index)
    rect = super
    rect.x = padding
    rect.width = contents.width - padding * 2
    rect
  end
  #--------------------------------------------------------------------------
  # ○ スロットモードか？
  #--------------------------------------------------------------------------
  def slot?
    true
  end
  #--------------------------------------------------------------------------
  # ● カーソルを上に移動
  #--------------------------------------------------------------------------
  def cursor_up
  end
  #--------------------------------------------------------------------------
  # ● カーソルを下に移動
  #--------------------------------------------------------------------------
  def cursor_down
  end
  #--------------------------------------------------------------------------
  # ● カーソルを右に移動
  #--------------------------------------------------------------------------
  def cursor_right(wrap)
  end
  #--------------------------------------------------------------------------
  # ● カーソルを左に移動
  #--------------------------------------------------------------------------
  def cursor_left(wrap)
  end
  #--------------------------------------------------------------------------
  # ● 決定ボタンが押されたときの処理
  #--------------------------------------------------------------------------
  def process_ok
    if @reels.any? {|reel| reel.rotation? }
      SUI::STRINPUT::SLOT_SE.play
      @reels[@index].stop
      @index += 1 if @index < @reels.size - 1
    else
      @selected = []
      @reels.each {|reel| @selected << reel.index}
      input_complete
    end
  end
  #--------------------------------------------------------------------------
  # ○ すべて入力済みか？
  #--------------------------------------------------------------------------
  def full?
    !@reels.any? {|reel| reel.rotation? }
  end
end


class Window_Message < Window_Base
  #--------------------------------------------------------------------------
  # ● 全ウィンドウの解放
  #--------------------------------------------------------------------------
  alias sui_sinput_dispose_all_windows dispose_all_windows
  def dispose_all_windows
    sui_sinput_dispose_all_windows
    @sinput_window.dispose if @sinput_window
  end
  #--------------------------------------------------------------------------
  # ● 全ウィンドウの更新
  #--------------------------------------------------------------------------
  alias sui_sinput_update_all_windows update_all_windows
  def update_all_windows
    sui_sinput_update_all_windows
    @sinput_window.update if @sinput_window
  end
  #--------------------------------------------------------------------------
  # ● 全ウィンドウが完全に閉じているか判定
  #--------------------------------------------------------------------------
  alias sui_sinput_all_close? all_close?
  def all_close?
    sui_sinput_all_close? && (!@sinput_window || @sinput_window.close?)
  end
  #--------------------------------------------------------------------------
  # ● 入力処理
  #--------------------------------------------------------------------------
  alias sui_sinput_process_input process_input
  def process_input
    if $game_message.sui_sinput?
      input_string_sinput
    else
      sui_sinput_process_input
    end
  end
  #--------------------------------------------------------------------------
  # ○ 文字入力の処理
  #--------------------------------------------------------------------------
  def input_string_sinput
    case $game_message.sui_sinput_type
    when "schoice"
      @sinput_window = Window_SuiStringInputChoice.new(self)
    when "sreel"
      @sinput_window = Window_SuiStringInputReel.new(self)
    when "sslot"
      @sinput_window = Window_SuiStringInputSlot.new(self)
    end
    Fiber.yield while @sinput_window.active || !@sinput_window.close?
    @sinput_window.dispose
    @sinput_window = nil
  end
end
