#include <GunItem.hpp>
#include <iostream>
using namespace godot;

void GunItem::_register_methods()
{
	register_method("use_item",&GunItem::use_item);
	register_property<GunItem,Ref<PackedScene>>("Weapon scene",&GunItem::weapon,Ref<PackedScene>(nullptr),
	GODOT_METHOD_RPC_MODE_DISABLED, GODOT_PROPERTY_USAGE_DEFAULT,GODOT_PROPERTY_HINT_RESOURCE_TYPE,"PackedScene");
}

void GunItem::_init()
{}

GunItem::GunItem()
{}

GunItem::~GunItem()
{}

bool GunItem::use_item(Node *obj)
{
	if (obj->is_in_group("Hero"))
	{
		obj->get_node("Drawing/Weapons")->add_child(weapon->instance());
		return false;
	}
	return true;
}

