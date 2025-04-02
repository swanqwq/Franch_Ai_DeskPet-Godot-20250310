extends Node2D
class_name Character
signal chat #这个信号负责把鼠标点击的事件传递给UI场景
var dragging = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
# 获取文件B的节点引用（假设文件B的节点路径是 /root/Main/B）
#@onready var file_b_node = get_node("/root/Main/B")
var click_count = 0  # 用于追踪左键点击次数
var last_click_time = 0  # 记录上次点击时间
const TRIPLE_CLICK_WINDOW = 0.5  # 三连击的时间窗口（秒）

@onready var chat_text: ChatText = $"../ChatText"
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer_2

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		
		if event.pressed:
			dragging = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			animation_player.play("anime_leg")
		else:
			dragging = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			animation_player.stop()  # 停止当前动画
			animation_player.play("RESET")  # 恢复到初始状态，如果你有一个RESET动画
			
	if event is InputEventMouseMotion and dragging:
		## 使用relative属性来移动窗口
		get_window().position += Vector2i(event.relative)
	if event.is_action_pressed("ChatStart"):
		#chat_text.show_menu_First = false
		chat.emit()#当按下ChatStart时(项目设置里定义的鼠标左键) 发出信号chat
		#animation_player_2.play("RESTLOG")
		animation_player.play("anime_shake")
		#if show_menu == false:
			#animation_player.play("anime_logBigger")
			#show_menu = not show_menu
		#else:
			#animation_player.play("anime_logSmaller")
			#show_menu = not show_menu
		

			
		
		
		# 检测三连击左键
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var current_time = Time.get_ticks_msec() / 1000.0
		
		# 检查是否在时间窗口内
		if current_time - last_click_time <= TRIPLE_CLICK_WINDOW:
			click_count += 1
		else:
			click_count = 1  # 超出时间窗口，重置计数
		
		last_click_time = current_time
		
		# 检查是否完成三连击
		if click_count == 2:
			animation_player.play("anime_bark")
			click_count = 0  # 重置计数器	




	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("QuitGame"):
		get_tree().quit()
