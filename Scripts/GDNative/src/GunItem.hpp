#pragma once
#include <Godot.hpp>
#include <Item.hpp>
#include <PackedScene.hpp>
#include <Sprite.hpp>
#include <String.hpp>

namespace godot
{

class GunItem:public Item
{
	GODOT_SUBCLASS(GunItem,Item)
private:
	Ref<PackedScene> weapon;
	String WeaponName;
public:
	static void _register_methods();
	void _init();
	
	GunItem();
	~GunItem();
	
	bool use_item(Node*);
};

}

