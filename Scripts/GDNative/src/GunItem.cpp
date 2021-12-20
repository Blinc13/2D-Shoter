#include <GunItem.hpp>
using namespace godot;

void GunItem::register_methods()
{
	register_method("use_item",&GunItem::use_item);
	
	//register_property<GunItem,PackedScene>("Weapon scene",&GunItem::weapon,NULL);
}

void GunItem::use_item(Node *obj)
{
	if (obj->is_in_group("Entity"))
	{
		obj->get_node("Drawing/Weapons")->add_child(weapon.instance());
	}
}
