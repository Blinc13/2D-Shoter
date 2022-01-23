#include <GunItem.hpp>
#include <Variant.hpp>
#include <iostream>
using namespace godot;

void GunItem::_register_methods()
{
	register_method("use_item",&GunItem::use_item);
	register_method("_ready",&GunItem::_ready);
	
	register_property<GunItem,Ref<PackedScene>>("Weapon scene",&GunItem::weapon,Ref<PackedScene>(nullptr),
	GODOT_METHOD_RPC_MODE_DISABLED, GODOT_PROPERTY_USAGE_DEFAULT,GODOT_PROPERTY_HINT_RESOURCE_TYPE,"PackedScene");
	
	register_property<GunItem,String>("WeaponName",&GunItem::WeaponName,"Testing it");
}

void GunItem::_init()
{}

void GunItem::_ready()
{
	args.append(WeaponName);
}

GunItem::GunItem()
{}

GunItem::~GunItem()
{}

bool GunItem::use_item(Node *obj)
{
	if (obj->is_in_group("Hero"))
	{
		Node *weapons=obj->get_node("Drawing/Weapons");
		
		if (!weapons->has_node(WeaponName)){
			Node *scene=weapon->instance();
			
			scene->set_name(WeaponName);
		
			
			weapons->add_child(scene);
			obj->call("inventoryUpdate",args);
			
			return false;
		}
	}
	return true;
}

