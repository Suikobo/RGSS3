#******************************************************************************
#   ＊ オプション画面 ＊
#                       for RGSS3
#        Ver 1.02   2015.04.30
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    ◆注意事項
      ※この素材は「共通セーブファイル」スクリプトが必要になります。
      ※この素材は睡工房の素材をカスタマイズするものです。
      　メッセージ機能拡張スクリプトを導入しない場合、機能２～５は無効となります。

    ◆機能説明
      １．ＢＧＭの再生ボリュームを変更できます。
      ２．ボイスの再生ボリュームを変更できます。
      ３．ボイス再生のオン/オフ切り替えができます。
      ４．文字表示速度の変更ができます。
      ５．自動改ページの待ち時間を変更できます。

    ◆使い方
      スクリプトで「Scene_Option.start」を実行すると、
      オプション画面が開きます。
      メニュー画面をカスタマイズしたい場合は、以下のURLを参考にしてください。
=end

#==============================================================================
# コンフィグ項目
#==============================================================================
module SUI
module OPTION
  # ボイス再生ボリューム変更時のサンプルボイス
  # 指定したボイスからランダムで１つ、新しいボリュームで再生されます。
  # サンプルボイスがいらない場合は空にしてください。
  SAMPLE = [
  #ファイル名
#  "sample_voice01",
#  "sample_voice02",
   "Cat",
   "Crow",
   "Dog",
  ]
  
  # ボイスファイルの保存場所
  #VOICE_DIR = "Audio/SE/Voice/"
  VOICE_DIR = "Audio/SE/"
end
end
#==============================================================================
# 設定完了
#==============================================================================



class Window_Option < Window_Base
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, 430, 330)
    self.openness = 0
    self.x = Graphics.width / 2 - self.width / 2
    self.y = Graphics.height / 2 - self.height / 2 + line_height / 2 + padding
    self.z = 160
    @line = 0
    set_index
    refresh
    update_cursor
  end
  #--------------------------------------------------------------------------
  # ● リフレッシュ
  #--------------------------------------------------------------------------
  def refresh
    self.contents.clear
    contents.font.color = normal_color
    contents.draw_text(0, 0 * rows_height, contents.width, line_height, "ＢＧＭボリューム")
    contents.draw_text(0, 1 * rows_height, contents.width, line_height, "ボイスボリューム")
    contents.draw_text(0, 2 * rows_height, contents.width, line_height, "キャラクターボイス")
    contents.draw_text(0, 3 * rows_height, contents.width, line_height, "メッセージ表示速度")
    contents.draw_text(0, 4 * rows_height, contents.width, line_height, "自動改ページ待ち時間")
    draw_command_10(0)
    draw_command_10(1)
    draw_command_2(2)
    draw_command_3(3)
    draw_command_3(4)
  end
  #--------------------------------------------------------------------------
  # ● 行の高さ（2行分）
  #--------------------------------------------------------------------------
  def rows_height
    60
  end
  #--------------------------------------------------------------------------
  # ● 文字の描画
  #--------------------------------------------------------------------------
  def draw_text2(x, y, w, text, blue = false)
    contents.font.color = blue ? system_color : normal_color
    contents.font.color.alpha = blue ? 255 : 128
    draw_text(x, y, w, line_height, text)
  end
  #--------------------------------------------------------------------------
  # ● 10コマンドの描画
  #--------------------------------------------------------------------------
  def draw_command_10(row)
    y = rows_height * row + line_height
    10.times do |i|
      x = 30 + 36 * i - ((i == 9) ? 2 : 0)
#~       draw_text2(x, y, 30, ((i + 1) * 10).to_s, (i == @index[row])) # Ver1.02
      draw_text2(x, y, 30, ((i + 1) * 10).to_s, (i == @settings[row])) # Ver1.02
    end
  end
  #--------------------------------------------------------------------------
  # ● 10コマンドの矩形を取得
  #--------------------------------------------------------------------------
  def item_rect_10
    rect = Rect.new
    rect.x = 30 - 9 + 36 * @index[@line]
    rect.y = rows_height * @line + line_height
    rect.width = 30 + 8
    rect.height = line_height
    rect
  end
  #--------------------------------------------------------------------------
  # ● 2コマンドの描画
  #--------------------------------------------------------------------------
  def draw_command_2(row)
    y = rows_height * row + line_height
    list = ["オン", "オフ"]
    2.times do |i|
      x = 30 + 100 * i
#~       draw_text2(x, y, 40, list[i], (i == @index[row]))    # Ver1.02
      draw_text2(x, y, 40, list[i], (i == @settings[row]))    # Ver1.02
    end
  end
  #--------------------------------------------------------------------------
  # ● 2コマンドの矩形を取得
  #--------------------------------------------------------------------------
  def item_rect_2
    rect = Rect.new
    rect.x = 30 - 11+ 100 * @index[@line]
    rect.y = rows_height * @line + line_height
    rect.width = 50 + 8
    rect.height = line_height
    rect
  end
  #--------------------------------------------------------------------------
  # ● 3コマンドの描画
  #--------------------------------------------------------------------------
  def draw_command_3(row)
    y = rows_height * row + line_height
    list = ["遅い", "普通", "速い"]
    3.times do |i|
      x = 30 + 80 * i
#~       draw_text2(x, y, 40, list[i], (i == @index[row]))    # Ver1.02
      draw_text2(x, y, 40, list[i], (i == @settings[row]))    # Ver1.02
    end
  end
  #--------------------------------------------------------------------------
  # ● 3コマンドの矩形を取得
  #--------------------------------------------------------------------------
  def item_rect_3
    rect = Rect.new
    rect.x = 30 - 11 + 80 * @index[@line]
    rect.y = rows_height * @line + line_height
    rect.width = 50 + 8
    rect.height = line_height
    rect
  end
  #--------------------------------------------------------------------------
  # ● カーソルの更新
  #--------------------------------------------------------------------------
  def update_cursor
    case @line
      when 0, 1
        cursor_rect.set(item_rect_10)
      when 2
        cursor_rect.set(item_rect_2)
      when 3, 4
        cursor_rect.set(item_rect_3)
      end
      Sound.play_cursor
  end
  #--------------------------------------------------------------------------
  # ● 行の設定
  #--------------------------------------------------------------------------
  def line=(row)
    old = @line
    @line = [[@line + row, 0].max, 4].min
    update_cursor if old != @line
  end
  #--------------------------------------------------------------------------
  # ● 行の設定
  #--------------------------------------------------------------------------
  def index=(i)
    max = 9 if( @line == 0 || @line == 1)
    max = 1 if( @line == 2)
    max = 2 if( @line == 3 || @line == 4)
    old = @index[@line]
    @index[@line] = [[@index[@line] + i, 0].max, max].min
    update_cursor if old != @index[@line]
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    super
    return unless self.openness == 255
    self.line = +1 if Input.repeat?(:DOWN)
    self.line = -1 if Input.repeat?(:UP)
    self.index = +1 if Input.repeat?(:RIGHT)
    self.index = -1 if Input.repeat?(:LEFT)
    if Input.trigger?(:C)
      Sound.play_use_item
      @settings[@line] = @index[@line]    # Ver1.02
      case @line
        when 0
          $savec.set_num("bgm_vol", (@index[@line] + 1) * 10)
          refresh
          RPG::BGM::last.play
        when 1
          $savec.set_num("voice_vol", (@index[@line] + 1) * 10)
          refresh
          Audio.se_stop
          vol = SUI::OPTION.voice_volume
          return if SUI::OPTION::SAMPLE.length == 0
          r = SUI::OPTION::SAMPLE[rand(SUI::OPTION::SAMPLE.length)]
          Audio.se_play("#{SUI::OPTION::VOICE_DIR}#{r}", 100 * vol)
        when 2
          $savec.set("voice", @index[@line] == 1)
          refresh
        when 3
          $savec.set_num("speed", @index[@line])
          refresh
        when 4
          $savec.set_num("auto_wait", @index[@line])
          refresh
        end
    end
  end
  #--------------------------------------------------------------------------
  # ● アクティブ設定
  #--------------------------------------------------------------------------
  def set_index
    @index = []
    
    res = $savec.get_num("bgm_vol")
    res = 70 if res < 10
    @index[0] = (res / 10) - 1
    
    res = $savec.get_num("voice_vol")
    res = 70 if res < 10
    @index[1] = (res / 10) - 1
    
    @index[2] = $savec.check("voice") ? 1 : 0
    
    @index[3] = $savec.get_num("speed")
    @index[3] = 1 if @index[3] == -1
    
    @index[4] = $savec.get_num("auto_wait")
    @index[4] = 1 if @index[4] == -1
    
    @settings = @index.dup      # Ver1.02
  end
end


class Scene_Option < Scene_Base
  #--------------------------------------------------------------------------
  # ● クラス変数初期化
  #--------------------------------------------------------------------------
  @@start  = false         # オプション画面の開始フラグ
  #--------------------------------------------------------------------------
  # ● 開始処理
  #--------------------------------------------------------------------------
  def start
    super
    @@start = false
    @config_seq = 0
    create_background
    create_option_window
    @option_window.open
    @option_title.open
  end
  #--------------------------------------------------------------------------
  # ● 終了処理
  #--------------------------------------------------------------------------
  def terminate
    super
    dispose_background
  end
  #--------------------------------------------------------------------------
  # ● オプションウィンドウの作成
  #--------------------------------------------------------------------------
  def create_option_window
    @option_window = Window_Option.new
    @option_title = Window_Help.new(1)
    @option_title.x = @option_window.x
    @option_title.width = @option_window.width
    @option_title.y = @option_window.y - @option_title.height
    @option_title.z = @option_window.z
    @option_title.create_contents
    @option_title.openness = 0
    @option_title.contents.draw_text(0, -2, @option_title.contents.width,@option_title.contents.height, "＊ コンフィグ ＊", 1)
  end
  #--------------------------------------------------------------------------
  # ● 背景の作成
  #--------------------------------------------------------------------------
  def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
  end
  #--------------------------------------------------------------------------
  # ● 背景の解放
  #--------------------------------------------------------------------------
  def dispose_background
    @background_sprite.dispose
  end
  #--------------------------------------------------------------------------
  # ● 更新処理
  #--------------------------------------------------------------------------
  def update
    super
    if Input.trigger?(:B)
      Sound.play_cancel
      @option_window.close
      @option_title.close
    end
    if @option_window.openness == 0
      SceneManager.return
    end
  end
  #--------------------------------------------------------------------------
  # ● オプション画面スタート処理
  #--------------------------------------------------------------------------
  def self.start
    @@start = true
  end
  #--------------------------------------------------------------------------
  # ● オプション画面が開始しているか？
  #--------------------------------------------------------------------------
  def self.start?
    return @@start
  end
end


module RPG
  class BGM < AudioFile
    #--------------------------------------------------------------------------
    # ● ＢＧＭの再生 ※再定義
    #--------------------------------------------------------------------------
    def play(pos = 0)
      if @name.empty?
        Audio.bgm_stop
        @@last = RPG::BGM.new
      else
        vol = SUI::OPTION::bgm_volume * 1.05
        vol = [@volume * vol, 100].min                          # Ver 1.01
        Audio.bgm_play("Audio/BGM/" + @name, vol, @pitch, pos)  # Ver 1.01
#~         Audio.bgm_play("Audio/BGM/" + @name, @volume * vol, @pitch, pos)
        @@last = self.clone
      end
    end
  end
end


class Scene_Map
  #--------------------------------------------------------------------------
  # ● オプション画面への移行
  #--------------------------------------------------------------------------
  alias sui_option_update_scene update_scene
  def update_scene
    sui_option_update_scene
    SceneManager.call(Scene_Option) if !scene_changing? && Scene_Option.start?
  end
end
