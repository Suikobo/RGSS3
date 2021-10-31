#******************************************************************************
#   ＊ ショートカット起動 ＊
#                       for RGSS3
#        Ver 1.00   2016.03.24
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
　□ 概要
　　　テストプレイ時にタイトル画面を飛ばすことができるようになります。

　□ 起動方法
　　１．いきなりニューゲーム
　　　　何もボタンを押さずに起動するとニューゲーム状態から始ります。

　　２．いきなりロード画面
　　　　Ctrlキーを押しながら起動するといきなりロード画面が開きます。
　　　　そのままキャンセルするとタイトル画面に戻ります。

　　３．タイトル画面から始める
　　　　Shiftキーを押しながら起動すると通常通りタイトル画面から始ります。
=end


class << SceneManager
  #--------------------------------------------------------------------------
  # ● 最初のシーンクラスを取得
  #--------------------------------------------------------------------------
  alias sui_shortcut_first_scene_class first_scene_class
  def first_scene_class
    if scene = shortcut_boot_scene
      return scene
    end
    sui_shortcut_first_scene_class
  end
end

module SceneManager
  #--------------------------------------------------------------------------
  # □ ショートカット起動
  #--------------------------------------------------------------------------
  def self.shortcut_boot_scene
    return nil unless $TEST
    Input.update
    return nil if Input.press?(:SHIFT)
    return setup_continue if Input.press?(:CTRL)
    return setup_new_game
  end
  #--------------------------------------------------------------------------
  # □ ニューゲームセットアップ
  #--------------------------------------------------------------------------
  def self.setup_new_game
    DataManager.setup_new_game
    $game_map.autoplay
    return Scene_Map
  end
  #--------------------------------------------------------------------------
  # □ コンティニューセットアップ
  #--------------------------------------------------------------------------
  def self.setup_continue
    @stack.push(Scene_Title.new)
    return Scene_Load
  end
end
