#pragma once
#include <Item.hpp>
#include <PackedScene.hpp>


namespace godot
{

class GunItem:public Item
{
	GODOT_SUBCLASS(GunItem,Item)
private:
	PackedScene weapon;
public:
	void register_methods();
	void _init();
	
	GunItem();
	~GunItem();
	
	void use_item(Node*);
};

}

