#******************************************************************************
#   ＊ タイマー一時停止 ＊
#                       for RGSS3
#        Ver 1.00   2016.03.20
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    ◆使い方
      １．一時停止
          イベントコマンドのスクリプトで「$game_timer.pause」
 
      ２．再開
          イベントコマンドのスクリプトで「$game_timer.resume」
 
      ３．一時停止中かを判定
          イベントコマンドのスクリプトで「$game_timer.pause?」
=end

class Game_Timer
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  alias sui_timer_initialize initialize
  def initialize
    sui_timer_initialize
    @count = -1
  end
  #--------------------------------------------------------------------------
  # □ 一時停止中かを判定
  #--------------------------------------------------------------------------
  def pause?
    @working == false
  end
  #--------------------------------------------------------------------------
  # □ 一時停止
  #--------------------------------------------------------------------------
  def pause
    @working = false
  end
  #--------------------------------------------------------------------------
  # □ 再開
  #--------------------------------------------------------------------------
  def resume
    @working = true
  end
  #--------------------------------------------------------------------------
  # ● 停止　※再定義
  #--------------------------------------------------------------------------
  def stop
    @working = false
    @count = -1
  end
  #--------------------------------------------------------------------------
  # ● 作動中判定　※再定義
  #--------------------------------------------------------------------------
  def working?
    @count >= 0
  end
end
