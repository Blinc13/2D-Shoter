#include <Godot.hpp>
#include <Node.hpp>
#include "Item.hpp"

namespace godot
{

class FirstAidKit:public Item
{
	GODOT_SUBCLASS(FirstAidKit,Item)
private:
	float health;
public:
	static void _register_methods();
	void _init();
	
	FirstAidKit();
	~FirstAidKit();
	
	bool use_item(Node*);
};

}
