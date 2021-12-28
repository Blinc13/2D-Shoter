#include <Godot.hpp>
#include <Node.hpp>
#include <Array.hpp>
#include "Item.hpp"

namespace godot
{

class FirstAidKit:public Item
{
	GODOT_SUBCLASS(FirstAidKit,Item)
private:
	float health=40;
	Array args;
public:
	static void _register_methods();
	void _init();
	
	FirstAidKit();
	~FirstAidKit();
	
	void set_args(float);
	bool use_item(Node*);
};

}
