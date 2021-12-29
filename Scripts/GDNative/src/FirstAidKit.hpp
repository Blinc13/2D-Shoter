#include <Godot.hpp>
#include <Node.hpp>
#include <Array.hpp>
#include <Particles2D.hpp>
#include "Item.hpp"

namespace godot
{

class FirstAidKit:public Item
{
	GODOT_SUBCLASS(FirstAidKit,Item)
private:
	float health=40;
	Array args;
	
	Particles2D *eff;
public:
	static void _register_methods();
	void _init();
	
	FirstAidKit();
	~FirstAidKit();
	
	void _ready();
	
	void effect();
	void set_args(float);
	bool use_item(Node*);
};

}
