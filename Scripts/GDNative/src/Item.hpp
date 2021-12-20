#pragma once
#include <Godot.hpp>
#include <Sprite.hpp>
#include <Area2D.hpp>
#include <Timer.hpp>

namespace godot
{

class Item:public Sprite
{
	GODOT_CLASS(Item,Sprite)
private:
	float relTime;
	
	Area2D *area;
	Timer	 *timer;
public:
	static void _register_methods();
	void _init();
	
	Item();
	~Item();
	
	void _ready();
	
	void use_item(Variant);
	void Activated(Variant);
	void TimeOut();
};

}
