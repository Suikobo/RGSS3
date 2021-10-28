#******************************************************************************
#   ＊ WAVE式バトル ＊
#                       for RGSS3
#        Ver 1.00   2016.04.10
#   提供者：睡工房
#   This program is a free license.
#******************************************************************************

=begin
    機能
      １つの戦闘で複数の敵グループとの戦いを演出するWAVE式を追加します。
      ※WAVE式はイベントコマンドからのバトルのみ対応しています。
      　ランダムエンカウントでは利用できません。

    使い方
    　１．WAVE式にしたいバトルのタイミングで注釈に以下のタグを記述してください。
    　　　タグ… <wave_battle n>
                              n … 何WAVE目かを演出するコモンイベントID
  　　
  　　２．注釈に続いて、「バトルの処理」を必要なだけ並べてください。
  　　　　※並べた順番に戦います。
  　　　　※逃走可能や負け継続のチェックは最後の「バトルの処理」で設定。
  　　　　※「バトルの処理」以外のイベントコマンドを間に挟まないでください。
  
  　　３．最後の「バトルの処理」の時点で戦闘開始です。
  
  
  　演出方法
  　　各WAVEの開始直前に、上記タグで設定したコモンイベントが呼ばれます。
  　　また、下記設定項目で指定したゲーム変数に「何WAVE目か」と「最大何WAVEか」
  　　の数値が入力されています。
  　　このゲーム変数をで条件分岐して、何WAVE目！という演出処理を作成して下さい。
  
  　☆敵キャラの行動パターンについて
  　　この素材では全体を１つの戦闘として扱うため、2WAVE以降でも経過ターン数は
  　　リセットされず、前WAVEの経過ターンの続きから始まります。
  　　「行動条件のターン数」で○WAVEの○ターン目という風に指定したい場合は
  　　メモ欄に「<wave_turns>」というタグを追加して下さい。
  　　このタグがある敵キャラの行動条件ではWAVE毎の経過ターン数が使用されます。
  
  　☆バトルイベントのターン条件について
  　　このターン条件でも、敵キャラと同じく経過ターン数はリセットされません。
  　　○WAVEの○ターン目という風に設定したい場合は、各ページのイベントに
  　　注釈コマンドの１行目に「<wave_turns>」というタグを追加して下さい。
  　　このタグがあるバトルイベントではWAVE毎の経過ターン数で条件判断されます。
  
  　☆「逃走可能」と「負けた場合も継続」の途中変更について
  　　スクリプトで以下のコマンドを実行して下さい。
  
　　　　逃走可能：BattleManager.wave_escape(flag)
　　　　　　引数：flag => 「true」で逃走可能、「false」で逃走不可となります。

　　　　負け継続：BattleManager.wave_lose(flag)
　　　　　　引数：flag => 「true」で継続、「false」でゲームオーバーとなります。
      
=end

  
#==============================================================================
# 設定項目
#==============================================================================
module SUI
module WAVE
  # 現在のWAVE数が保存されるゲーム変数ＩＤ
  WAVE_NOW = 15

  # WAVEの総数が保存されるゲーム変数ＩＤ
  WAVE_MAX = 16
end
end
#==============================================================================
# 設定完了
#==============================================================================


class << BattleManager
  #--------------------------------------------------------------------------
  # ● 勝敗判定
  #--------------------------------------------------------------------------
  alias sui_wave_judge_win_loss judge_win_loss
  def judge_win_loss
    if wave_battle? && $game_troop.all_dead?
      # 次のWAVEがある場合は勝敗判定キャンセル
      if wave_next
        SceneManager.scene.battle_start
        return false
      end
    end
    sui_wave_judge_win_loss
  end
end


module BattleManager
  include SUI::WAVE
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの初期化
  #--------------------------------------------------------------------------
  def self.wave_initialize(common_id)
    @wave = []
    @wave_common = common_id
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの事前コモンイベントＩＤ取得
  #--------------------------------------------------------------------------
  def self.wave_common_id
    @wave_common
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルのリセット
  #--------------------------------------------------------------------------
  def self.wave_reset
    @wave = nil
  end
  #--------------------------------------------------------------------------
  # □ WAVEの追加
  #--------------------------------------------------------------------------
  def self.wave_push(tid)
    @wave.push(tid)
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルのセットアップ
  #--------------------------------------------------------------------------
  def self.wave_setup(can_escape = true, can_lose = false)
    init_members
    wave_init_variables
    @can_escape = can_escape
    @can_lose = can_lose
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの「逃走可能」フラグ変更
  #--------------------------------------------------------------------------
  def self.wave_escape(flag)
    @can_escape = (flag) ? true : false
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの「負けた場合も継続」フラグ変更
  #--------------------------------------------------------------------------
  def self.wave_lose(flag)
    @can_lose = (flag) ? true : false
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの変数の初期化
  #--------------------------------------------------------------------------
  def self.wave_init_variables
    @victory = false
    $game_variables[WAVE_NOW] = 0
    $game_variables[WAVE_MAX] = @wave.size
    $game_party.wave_init_variables
    $game_troop.wave_init_variables
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルかを判定
  #--------------------------------------------------------------------------
  def self.wave_battle?
    @wave
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルに勝利したかを判定
  #--------------------------------------------------------------------------
  def self.victory?
    @victory
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルを次のステージへ
  #--------------------------------------------------------------------------
  def self.wave_next
    $game_troop.gain_drops if $game_variables[WAVE_NOW] > 0
    if $game_variables[WAVE_NOW] < $game_variables[WAVE_MAX]
      $game_troop.setup(@wave[$game_variables[WAVE_NOW]])
      $game_variables[WAVE_NOW] += 1
      make_escape_ratio
      return true
    else
      @victory = true
      return false
    end
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの初期化が終わっているか
  #--------------------------------------------------------------------------
  def self.wave_initialized?
    return false unless wave_battle?
    return false if $game_variables[WAVE_NOW] == 0
    return true
  end
end


class Game_Interpreter
  #--------------------------------------------------------------------------
  # ● 注釈
  #--------------------------------------------------------------------------
  alias sui_wave_command_108 command_108
  def command_108
    sui_wave_command_108
    check_wave_battle
  end
  #--------------------------------------------------------------------------
  # ● バトルの処理
  #--------------------------------------------------------------------------
  alias sui_wave_command_301 command_301
  def command_301
    return if $game_party.in_battle
    return command_wave_battle if @wave_battle
    sui_wave_command_301
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの検出
  #--------------------------------------------------------------------------
  def check_wave_battle
    @comments.each do |line|
      if line =~ /<wave_battle\s+(\d+)>/
        BattleManager.wave_initialize($1.to_i)
        @wave_battle = true 
      end
    end
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの処理
  #--------------------------------------------------------------------------
  def command_wave_battle
    if @params[0] == 0                      # 直接指定
      troop_id = @params[1]
    elsif @params[0] == 1                   # 変数で指定
      troop_id = $game_variables[@params[1]]
    else                                    # マップ指定の敵グループ
      troop_id = $game_player.make_encounter_troop_id
    end

    # WAVEのスタックに追加
    if $data_troops[troop_id]
      BattleManager.wave_push(troop_id)
    end

    # 次のイベントコードがバトルの処理じゃない場合はスタック追加完了、戦闘開始。
    if next_event_code != 301
      @wave_battle = false
      BattleManager.wave_setup(@params[2], @params[3])
      BattleManager.event_proc = Proc.new {|n| @branch[@indent] = n }
      $game_player.make_encounter_count
      SceneManager.call(Scene_Battle)
      Fiber.yield
    end
  end
end


class Game_Party < Game_Unit
  #--------------------------------------------------------------------------
  # ● 戦闘開始処理
  #--------------------------------------------------------------------------
  alias sui_wave_on_battle_start on_battle_start
  def on_battle_start
    # Wave式バトルの時、Wave2以降では処理しない
    return if BattleManager.wave_battle? && @started
    sui_wave_on_battle_start
    @started = true
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの変数の初期化
  #--------------------------------------------------------------------------
  def wave_init_variables
    @started = false
  end
  #--------------------------------------------------------------------------
  # □ in_battle強制
  #--------------------------------------------------------------------------
  def wave_battle_start
    @in_battle = true
  end
end


class Game_Troop < Game_Unit
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_reader   :wave_turn_count               # WAVE単位でのターン数
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの変数の初期化
  #--------------------------------------------------------------------------
  def wave_init_variables
    @wave_turn_count = 0
    @total_exp  = 0
    @total_gold = 0
    @total_item = []
  end
  #--------------------------------------------------------------------------
  # ● クリア
  #--------------------------------------------------------------------------
  alias sui_wave_clear clear
  def clear
    if BattleManager.wave_initialized?
      # ２戦目以降
      wave_clear
    else
      sui_wave_clear
      @wave_turn_count = 0
    end
  end
  #--------------------------------------------------------------------------
  # □ WAVE毎のクリア
  #--------------------------------------------------------------------------
  def wave_clear
    @event_flags.clear
    @wave_turn_count = 0
  end
  #--------------------------------------------------------------------------
  # ● ターンの増加
  #--------------------------------------------------------------------------
  alias sui_wave_increase_turn increase_turn
  def increase_turn
    sui_wave_increase_turn
    @wave_turn_count += 1
  end
  #--------------------------------------------------------------------------
  # □ 戦利品を積んでおく
  #--------------------------------------------------------------------------
  def gain_drops
    @total_exp  += exp_total
    @total_gold += gold_total
    @total_item += make_drop_items
  end
  #--------------------------------------------------------------------------
  # ● 経験値の合計計算
  #--------------------------------------------------------------------------
  alias sui_wave_exp_total exp_total
  def exp_total
    if BattleManager.wave_battle? && BattleManager.victory?
      return @total_exp
    end
    sui_wave_exp_total
  end
  #--------------------------------------------------------------------------
  # ● お金の合計計算
  #--------------------------------------------------------------------------
  alias sui_wave_gold_total gold_total
  def gold_total
    if BattleManager.wave_battle? && BattleManager.victory?
      return @total_gold
    endd
    end
    sui_wave_gold_total
  end
  #--------------------------------------------------------------------------
  # ● ドロップアイテムの配列作成
  #--------------------------------------------------------------------------
  alias sui_wave_make_drop_items make_drop_items
  def make_drop_items
    if BattleManager.wave_battle? && BattleManager.victory?
      return @total_item
    end
    sui_wave_make_drop_items
  end
  #--------------------------------------------------------------------------
  # ● バトルイベント（ページ）の条件合致判定
  #--------------------------------------------------------------------------
  alias sui_wave_conditions_met? conditions_met?
  def conditions_met?(page)
    if wave_turns?(page.list)
      # WAVE単位化の時は一時的に書き換え
      last = @turn_count
      @turn_count = @wave_turn_count
    end
    
    result = sui_wave_conditions_met?(page)
    
    if last
      @turn_count = last
    end
    return result
  end
  #--------------------------------------------------------------------------
  # □ WAVE単位化のタグが最初のコメントにあるか判定
  #--------------------------------------------------------------------------
  def wave_turns?(list)
    list.each do |command|
      if command.code == 108 && command.parameters[0] =~ /<wave_turns>/
        return true
      end
    end
    return false
  end
end


class Game_Enemy < Game_Battler
  #--------------------------------------------------------------------------
  # ● 行動条件合致判定［ターン数］
  #--------------------------------------------------------------------------
  alias sui_wave_conditions_met_turns? conditions_met_turns?
  def conditions_met_turns?(param1, param2)
    if BattleManager.wave_battle? && wave_turns?
      return conditions_met_wave_turns?(param1, param2)
    else
      return sui_wave_conditions_met_turns?(param1, param2)
    end
  end
  #--------------------------------------------------------------------------
  # □ 行動条件合致判定［WAVE単位のターン数］
  #--------------------------------------------------------------------------
  def conditions_met_wave_turns?(param1, param2)
    n = $game_troop.wave_turn_count
    if param2 == 0
      n == param1
    else
      n > 0 && n >= param1 && n % param2 == param1 % param2
    end
  end
  #--------------------------------------------------------------------------
  # □ WAVE単位化のタグがメモにあるか判定
  #--------------------------------------------------------------------------
  def wave_turns?
    enemy.note =~ /<wave_turns>/
  end
end
  


class Scene_Battle < Scene_Base
  #--------------------------------------------------------------------------
  # ● 開始処理
  #--------------------------------------------------------------------------
  alias sui_wave_start start
  def start
    BattleManager.wave_next if BattleManager.wave_battle?
    sui_wave_start
  end
  #--------------------------------------------------------------------------
  # ● 終了処理
  #--------------------------------------------------------------------------
  alias sui_wave_terminate terminate
  def terminate
    BattleManager.wave_reset
    sui_wave_terminate
  end
  #--------------------------------------------------------------------------
  # ● 戦闘開始
  #--------------------------------------------------------------------------
  alias sui_wave_battle_start battle_start
  def battle_start
    @spriteset.dispose_enemies
    @spriteset.create_enemies
    setup_wave_common_event
    sui_wave_battle_start
  end
  #--------------------------------------------------------------------------
  # □ WAVE式バトルの事前コモンイベントセットアップ
  #--------------------------------------------------------------------------
  def setup_wave_common_event
    return unless BattleManager.wave_battle?
    $game_party.wave_battle_start
    $game_temp.reserve_common_event(BattleManager.wave_common_id)
    process_event
  end
end
