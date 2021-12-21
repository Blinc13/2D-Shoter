#include <Hero.hpp>
#include <InputEventMouseMotion.hpp>
#include <InputEventJoypadMotion.hpp>
#include <Ref.hpp>
using namespace godot;

void Hero::_register_methods()
{
	register_method("_ready",&Hero::_ready);
	register_method("_process",&Hero::_process);
	register_method("_input",&Hero::_input);
}

void Hero::_init()
{
	input=Input::get_singleton();
}

Hero::Hero()
{}
Hero::~Hero()
{}

void Hero::_ready()
{
	WeaponList=get_node("Drawing/Weapons");
	weapon=WeaponList->get_child(0);
	
	DrawingObj=cast_to<Node2D>(get_node("Drawing"));
	AnimationObj=cast_to<AnimatedSprite>(get_node("Drawing/AnimatedSprite"));
	Cam=cast_to<Camera2D>(get_node("Camera2D"));
}

void Hero::_input(Variant event)
{
	Ref<InputEventMouseMotion> ev=event;
	
	firePos=get_local_mouse_position().normalized();
	
	DrawingObj->set_rotation(firePos.angle());
	Cam->set_offset(firePos);
}

void Hero::_process(float delta)
{
	ChReload+=delta;
	DsReload+=delta;
	
	Vector2 velocity=input->get_vector("Left","Right","Up","Down");
	
	move_and_slide(velocity*Speed);
}
