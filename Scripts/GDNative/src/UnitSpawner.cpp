#include "UnitSpawner.hpp"
using namespace godot;

void UnitSpawner::_register_methods()
{
	register_method("reinit",&UnitSpawner::reinit);
	register_method("_process",&UnitSpawner::_process);
	
	register_property<UnitSpawner,float>("Delay",&UnitSpawner::delay,20.0F);
	register_property<UnitSpawner,int>("Max Units",&UnitSpawner::MaxUnits,10);
	
	register_property<UnitSpawner,Ref<PackedScene>>("Unit scene",
	&UnitSpawner::Unit,Ref<PackedScene>(nullptr),GODOT_METHOD_RPC_MODE_DISABLED,
	GODOT_PROPERTY_USAGE_DEFAULT,GODOT_PROPERTY_HINT_RESOURCE_TYPE,"PackedScene");
	
	register_signal<UnitSpawner>("unit_spawned","Unit",GODOT_VARIANT_TYPE_OBJECT);
}

void UnitSpawner::_init()
{}

UnitSpawner::UnitSpawner()
{}
UnitSpawner::~UnitSpawner()
{}

void UnitSpawner::reinit(Ref<PackedScene> node,float i)
{
	delay=i;
	Unit=node;
}

void UnitSpawner::_process(float delta)
{
	time+=delta;
	
	if (time>delay && get_child_count()<MaxUnits)
	{
		Node *unit=Unit->instance();
		add_child(unit);
		emit_signal("unit_spawned",Variant(unit));
		time=0;
	}
}
