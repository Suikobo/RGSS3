#******************************************************************************
#   ＊ ピクチャ選択肢 ＊
#                       for RGSS3
#        Ver 1.02   2016.02.24
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    機能
      選択肢をピクチャ化することができます。

    使い方
      選択肢の項目欄に以下のコマンドを入力して下さい。
      
      書式　pic:filename x=num y=num
      引数　filename -> Picturesフォルダに保存してあるファイル名
            x        -> ピクチャを表示するＸ座標
            y        -> ピクチャを表示するＹ座標
            ※x, y の引数は省略可能です。
              省略した場合、自動計算された位置に表示されます。
      
      例１）pic:pic_yes
      例２）pic:pic_yes x=10
      例３）pic:pic_yes y=10
      例４）pic:pic_yes x=10 y=10


    ※睡工房素材「自由選択肢」で使用する場合、
    　　アイテムタグのtextに同じ書式で記述して下さい。
    　
      例１）<item 10 pic:pic_yes>
      例２）<item 10 pic:pic_yes x=10>
      例３）<item 10 pic:pic_yes y=10>
      例４）<item 10 pic:pic_yes x=10 y=10>
=end


class Window_ChoiceList < Window_Command
  
#==============================================================================
# 設定項目
#==============================================================================
  # 選択されていないピクチャのトーン補正値
  DARK = -32
  
  # ←→キーでも項目を選択できるようにする場合は true
  LR_SELECT = true
  
  # スプライトのＺ座標       # Ver 1.02 addition
  SPRITE_Z = 9999
#==============================================================================
# 設定完了
#==============================================================================


#---------------------------------------------------< Ver 1.01 addition start
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  alias sui_pchoice_dispose dispose
  def dispose
    sui_pchoice_dispose
    sprites_dispose
  end
#---------------------------------------------------< Ver 1.01 addition end
  #--------------------------------------------------------------------------
  # ● 項目の選択
  #--------------------------------------------------------------------------
  def select(index)
    super
    return unless @sprites
    @sprites.each_with_index do |sprite, i|
      if i == index
        sprite.tone.set(0, 0, 0, 0)
      else
        sprite.tone.set(DARK, DARK, DARK, 0)
      end
    end
  end
  #--------------------------------------------------------------------------
  # ● カーソルを右に移動
  #--------------------------------------------------------------------------
  def cursor_right(wrap = false)
    cursor_down(wrap) if LR_SELECT
  end
  #--------------------------------------------------------------------------
  # ● カーソルを左に移動
  #--------------------------------------------------------------------------
  def cursor_left(wrap = false)
    cursor_up(wrap) if LR_SELECT
  end
  #--------------------------------------------------------------------------
  # ● コマンドリストの作成
  #--------------------------------------------------------------------------
  alias sui_pichoice_make_command_list make_command_list
  def make_command_list
    sui_pichoice_make_command_list
    return if self.disposed?
    make_picture_choice
    adjust_sprites_position if @sprites
  end
  #--------------------------------------------------------------------------
  # □ ピクチャ選択肢の作成
  #--------------------------------------------------------------------------
  def make_picture_choice
    if $game_message.choices.any? {|item| item =~ /^pic:.+/ }
      self.opacity = 0
      self.contents_opacity = 0
    else
      self.opacity = 255
      self.contents_opacity = 255
      return
    end

    @sprites = []
    $game_message.choices.each do |item|
      @sprites << Sprite_PicChoice.new
      text = item.clone
      text.sub!(/x\s*=\s*([-+]?\d+)/)  { @sprites[-1].user_x = $1.to_i; "" }
      text.sub!(/y\s*=\s*([-+]?\d+)/)  { @sprites[-1].user_y = $1.to_i; "" }
      text.strip.sub!(/pic:(.+)/) { @sprites[-1].filename = $1; "" }
      @sprites[-1].opacity = 0
      @sprites[-1].tone = Tone.new(DARK, DARK, DARK, 0)
      @sprites[-1].z = SPRITE_Z + @sprites.size          # Ver 1.02 addition
    end
  end
  #--------------------------------------------------------------------------
  # □ スプライトの位置調整
  #--------------------------------------------------------------------------
  def adjust_sprites_position
    total = 0
    row   = 0
    temp = [[]]
    
    # X座標自動調整
    @sprites.each do |sprite|
      if (total + sprite.width) > Graphics.width
        adjust_sprites_position_x(temp[row], total)
        total = 0
        row += 1
        temp << []
      end
      total += sprite.width
      temp[row] << sprite
    end
    adjust_sprites_position_x(temp[row], total)
    
    # Y座標自動調整
    total = temp.inject(0) do |result, row|
      result += (row.max {|a, b| a.height <=> b.height }).height
    end
    adjust_sprites_position_y(temp, total)
    
    # ユーザー指定位置に再調整
    @sprites.each {|sprite| sprite.adjust_position }
  end
  #--------------------------------------------------------------------------
  # □ スプライトのX座標調整
  #--------------------------------------------------------------------------
  def adjust_sprites_position_x(sprites, total)
    space = (Graphics.width - total) / (sprites.size + 1)
    sprite_x = space
    sprites.each do |sprite|
      sprite.x = sprite_x
      sprite_x += (sprite.width + space)
    end
  end
  #--------------------------------------------------------------------------
  # □ スプライトのY座標調整
  #--------------------------------------------------------------------------
  def adjust_sprites_position_y(sprites, total)
    area  = Graphics.height
    area -= @message_window.height if @message_window.open?
    space = (area - total) / (sprites.size + 3)
    sprite_y = space * 2
    if @message_window.open? && @message_window.y == 0
      sprite_y += @message_window.height
    end
    sprites.each do |row|
      max_height = (row.max {|a, b| a.height <=> b.height }).height
      row.each do |sprite|
        inner_space = (max_height - sprite.height) / 2
        sprite.y = sprite_y + inner_space
      end
      sprite_y += (max_height + space)
    end
  end
  #--------------------------------------------------------------------------
  # ● 開く処理の更新
  #--------------------------------------------------------------------------
  def update_open
    super
    return unless @sprites
    @sprites.each {|sprite| sprite.opacity = self.openness}
  end
  #--------------------------------------------------------------------------
  # ● 閉じる処理の更新
  #--------------------------------------------------------------------------
  def update_close
    super
    return unless @sprites
    @sprites.each {|sprite| sprite.opacity = self.openness}
    sprites_dispose if self.openness <= 0
  end
  #--------------------------------------------------------------------------
  # □ ピクチャの解放
  #--------------------------------------------------------------------------
  def sprites_dispose
    return unless @sprites      # Ver 1.02 addition
    @sprites.each do |sprite|
      sprite.bitmap = nil
      sprite.dispose
      sprite = nil
    end
    @sprites = nil
  end
end


class Sprite_PicChoice < Sprite
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_accessor   :user_x             # X座標（ユーザ指定値）
  attr_accessor   :user_y             # Y座標（ユーザ指定値）
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(viewport = nil)
    super(viewport)
    @user_x = nil
    @user_y = nil
  end
  #--------------------------------------------------------------------------
  # □ ファイル名でのBitmap指定
  #--------------------------------------------------------------------------
  def filename=(name)
    self.bitmap = Cache.picture(name)
  end
  #--------------------------------------------------------------------------
  # □ 位置調整
  #--------------------------------------------------------------------------
  def adjust_position
    self.x = @user_x if @user_x
    self.y = @user_y if @user_y
  end
end
