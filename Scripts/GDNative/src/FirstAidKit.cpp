#include "FirstAidKit.hpp"

using namespace godot;

void FirstAidKit::_register_methods()
{
	register_method("use_item",&FirstAidKit::use_item);
	
	register_property<FirstAidKit,float>("Heal",&FirstAidKit::health,40);
}

void FirstAidKit::_init()
{}

FirstAidKit::FirstAidKit()
{}
FirstAidKit::~FirstAidKit()
{}

bool FirstAidKit::use_item(Node *obj)
{
	return true;
}
