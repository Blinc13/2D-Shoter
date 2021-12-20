#pragma once
#include "Item.hpp"

using namespace godot;

void Item::_register_methods()
{
	register_method("_ready",&Item::_ready);
	register_method("Activated",&Item::Activated);
	register_method("TimeOut",&Item::TimeOut);
	register_method("use_item",&Item::use_item);
	
	register_property<Item,float>((char*)"Rel Time",&Item::relTime,10.0F);
	
	register_signal<Item>((char*)"used");
}

Item::Item()
{}

Item::~Item()
{}

void Item::_init()
{}

void Item::_ready()
{
	area=cast_to<Area2D>(get_node("Area2D"));
	timer=cast_to<Timer>(get_node("Timer"));
}

void Item::Activated(Variant obj)
{
	area->set_deferred("monitoring",false);
	timer->start(relTime);
	emit_signal("used");
}

void Item::TimeOut()
{
	area->set_deferred("monitoring",true);
}

void Item::use_item(Variant obj)
{}
