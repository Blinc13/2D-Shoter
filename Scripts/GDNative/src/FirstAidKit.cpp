#include "FirstAidKit.hpp"
#include <Array.hpp>
#include <Dictionary.hpp>
#include <iostream>

using namespace godot;

void FirstAidKit::_register_methods()
{
	register_method("use_item",&FirstAidKit::use_item);
	
	register_property<FirstAidKit,float>("Heal",&FirstAidKit::health,40);
}

void FirstAidKit::_init()
{
	args.append(-health);
}

FirstAidKit::FirstAidKit()
{}
FirstAidKit::~FirstAidKit()
{}

bool FirstAidKit::use_item(Node *obj)
{
	if (obj->is_in_group("Hero"))
	{
		float x=obj->get("health"),
					y=obj->get("maxHealth");
		
		if (y-x>health)
			set_args(health);
		else
			set_args(y-x);
			
		obj->call("damage",args);
		
		return false;
	}
	
	return true;
}

void FirstAidKit::set_args(float num)
{
	args.clear();
	args.append(-num);
}
