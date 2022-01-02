#include <Godot.hpp>
#include <Node2D.hpp>
#include <PackedScene.hpp>

namespace godot
{

class UnitSpawner:public Node2D
{
	GODOT_CLASS(UnitSpawner,Node2D)
private:
	float delay=20.0F,time=0;
	int MaxUnits=10;
	Ref<PackedScene> Unit;
public:
	static void _register_methods();
	void _init();
	
	UnitSpawner();
	~UnitSpawner();
	
	void reinit(Ref<PackedScene>,float);
	void _process(float);
};

}
