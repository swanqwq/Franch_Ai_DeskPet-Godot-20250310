extends Label
class_name ChatText
var con_id: String #创建的对话id
signal  request_finished
#声明请求结束信号，表示接受到AI文本的请求完成
var output: String 
#var answer: String  # 将 answer 定义为全局变量
#var questionNow: String  # 将 question 定义为全局变量
@onready var chat_text: ChatText = $"."

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var create_dialog: HTTPRequest = $CreateDialog
@onready var ask_question: HTTPRequest = $AskQuestion
#@onready var line_edit: LineEdit = $Control/PanelContainer/VBoxContainer/LineEdit
@onready var line_edit: LineEdit = $Control/PanelContainer/VBoxContainer/LineEdit
@onready var rich_text_label: RichTextLabel = $Control/PanelContainer/VBoxContainer/RichTextLabel
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer_2

@onready var collision_shape_2d: CollisionShape2D = $Sprite2D/Area2D/CollisionShape2D
@onready var area_2d: Area2D = $Sprite2D/Area2D
@onready var collision_shape_2d_chat: CollisionShape2D = $CollisionShape2D_Chat


var sentences : Array[String]
var show_menu_First:bool = true
var show_menu:bool = false
var mouse_inside_area:bool = false

func _input(event):
	if show_menu_First == true:
		animation_player_2.play("RESETLOG")
	# 检查事件是否为鼠标按钮按下，特别是右键
	#if event.is_action_pressed("ChatStart"):
		#chat_text.show_menu_First = false
		#if show_menu == false:
			#animation_player_2.play("anime_logBigger")
			#show_menu = not show_menu
		#else:
			#animation_player_2.play("anime_logSmaller")
			#show_menu = not show_menu
			
			
			
func _ready() -> void:
# 确保 Area2D 节点存在后再连接信号
	if area_2d:
		area_2d.input_event.connect(_on_area_2d_input_event)
	else:
		print("错误：找不到 Area2D 节点")
	
	create()
	#输入1
	line_edit.text_submitted.connect(on_submitted)
	#line_edit.request_finished.connect(on_request_finished)
	#输出1
	create_dialog.request_completed.connect(_on_ask_question_request_completed)
	#输出2
	chat_text.request_finished.connect(on_request_finished)
	#获取输入的文字text_submitted，传入并调用函数on_submitted
	#line_edit.text_submitted.connect(on_submitted)

# 当鼠标进入 Area2D 时调用
func _on_area_2d_mouse_entered():
	mouse_inside_area = true

# 当鼠标离开 Area2D 时调用
func _on_area_2d_mouse_exited():
	mouse_inside_area = false



#发起创造对话请求
func create():
	var url := 'https://qianfan.baidubce.com/v2/app/conversation'
	var body := {
		"app_id": "b5a2a641-bda0-42fc-ac44-97f0a7ba38d4"
	}
	var headers := [        
		'Content-Type: application/json',
		'X-Appbuilder-Authorization : Bearer bce-v3/ALTAK-F1g6rNuL9nrEB2o7LKpAT/5370f0b33058b96b2badc028c97fbd211f6fdf32'
	]
	create_dialog.request(url,headers,HTTPClient.METHOD_POST,JSON.new().stringify(body))
	


#输出3
func on_request_finished(output:String):
	print("on_request_finished(output:String):"+output)
	show_text(output,1)
#输出4
func show_text(text:String, time:float):
		rich_text_label.text = text
		var tw = create_tween()
		tw.tween_property(rich_text_label,"visible_ratio",1,time).from(0)
				
#输入2
func on_submitted(new_text:String):
	ask(new_text)
	#ask("你好，给我写一首诗歌")
	
	show_text("Laisse-moi réfléchir",0.5)

		
		

func play_chat() ->void:
	animation_player.play("anime_shake")
	#定义函数plat_chat() 为播放ChatSpeaking动画

#输出1
#链接信号接收服务器响应
func _on_create_dialog_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json := JSON.new()
	json.parse(body.get_string_from_utf8())
	print(json.data)
	con_id = json.data['conversation_id']
	#ask("你今年几岁")
	#var response = JSON.parse_string(body.get_string_from_utf8())
	##把传入的数据解析并存入response字典
	#output = response['choices'][0].message.content
	##从字典内提取出第一个回答存入output字符串
	#request_finished.emit(output)
	#函数结束，传出信号并附带结果数据
	
	# 从LineEdit获取用户输入
	#questionNow = line_edit.text
	#print("questionNow"+questionNow)
	#if user_input != "":  # 检查非空输入
		##print(user_input)
		#ask(user_input)
		#line_edit.text = ""  # 清空输入框
	#ask(questionNow)	
	
# 新增一个发送消息的独立函数
#func _on_send_button_pressed():
	## 直接触发请求流程，可以从这里开始你的API调用
	#var user_input = line_edit.text
	#if user_input.strip() != "":
		#ask(user_input)
		#line_edit.text = ""
		
#输入3	
func ask(question: String):
	var url := 'https://qianfan.baidubce.com/v2/app/conversation/runs'
	var body := {
		"app_id": "b5a2a641-bda0-42fc-ac44-97f0a7ba38d4",
		"query": question,
		"stream": false,
		"conversation_id": con_id
	}
	var headers := [        
		'Content-Type: application/json',
		'X-Appbuilder-Authorization : Bearer bce-v3/ALTAK-F1g6rNuL9nrEB2o7LKpAT/5370f0b33058b96b2badc028c97fbd211f6fdf32'
	]
	ask_question.request(url,headers,HTTPClient.METHOD_POST,JSON.new().stringify(body))
	

#输出1
#接受
func _on_ask_question_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result == HTTPRequest.RESULT_SUCCESS and response_code == 200:
		#var raw_body = body.get_string_from_utf8()
		#print("原始响应内容:", raw_body)  # 调试输出
		var json := JSON.new()
		var parse_result = json.parse(body.get_string_from_utf8())
		if parse_result == OK:
			print("answer:", json.data.get("answer", "Bonjour, Hong Jiayi"))
			output = json.data.get("answer", "Bonjour, Hong Jiayi")
			request_finished.emit(output)
		else:
			print("JSON 解析失败")
	else:
		print("请求失败，状态码:", response_code)
	
	#var answer = json.data['answer']
		# 调试输出类型和内容
	#print("Type of answer: ", typeof(json.data['answer']))
#	print("Content of answer: ", json.data['answer'])
	#print("answer:"+answer)
	#update_response(answer)  # 替换原来的print语句
		# 提取字典中的字符串字段（假设字段名为 "text"）
		
	#var response = JSON.parse_string(body.get_string_from_utf8())
	##把传入的数据解析并存入response字典
	#output = response['choices'][0].message.content
	#print(output)
	##从字典内提取出第一个回答存入output字符串
	#request_finished.emit(output)
	#函数结束，传出信号并附带结果数据

## 在chat_text.gd中添加
#func update_response(answer: String):
	#text = answer  # 继承自Label的属性
	#play_chat()    # 播放显示动画


		


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		# 检查事件是否为鼠标按钮按下，特别是右键
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		chat_text.show_menu_First = false
		if show_menu == false:
			animation_player_2.play("anime_logBigger")
			show_menu = not show_menu
		else:
			animation_player_2.play("anime_logSmaller")
			show_menu = not show_menu
