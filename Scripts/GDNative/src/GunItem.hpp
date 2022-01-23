#pragma once
#include <Godot.hpp>
#include <Item.hpp>
#include <PackedScene.hpp>
#include <Sprite.hpp>
#include <String.hpp>
#include <Array.hpp>

namespace godot
{

class GunItem:public Item
{
	GODOT_SUBCLASS(GunItem,Item)
private:
	Ref<PackedScene> weapon;
	String WeaponName;
	
	Array args;
public:
	static void _register_methods();
	void _init();
	
	GunItem();
	~GunItem();
	
	void _ready();
	
	bool use_item(Node*);
};

}

