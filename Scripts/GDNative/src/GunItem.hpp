#pragma once
#include <Godot.hpp>
#include <Item.hpp>
#include <PackedScene.hpp>
#include <Sprite.hpp>

namespace godot
{

class GunItem:public Item
{
	GODOT_SUBCLASS(GunItem,Item)
private:
	Ref<PackedScene> weapon;
public:
	static void _register_methods();
	void _init();
	
	GunItem();
	~GunItem();
	
	bool use_item(Node*);
};

}

