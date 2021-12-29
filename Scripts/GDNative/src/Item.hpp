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
protected:
	float relTime=10.0F;
	
	Area2D *area;
	Timer	 *timer;
public:
	static void _register_methods();
	void _init();
	
	Item();
	~Item();
	
	void _ready();
	
	
	virtual bool use_item(Node*);
	virtual void effect();
	void Activated(Variant);
	void TimeOut();
};

}
