extends StaticBody2D

func player_punch(player): pass

func player_stomp(player): pass

func player_body_contact(player): pass

func player_body_uncontact(player): pass

func duck_player_body_contact(player):
	player.can_stand_up += 1

func duck_player_body_uncontact(player):
	player.can_stand_up -= 1
