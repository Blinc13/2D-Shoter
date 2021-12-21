#pragma once
#include <Godot.hpp>
#include <Node.hpp>
#include <Node2D.hpp>
#include <AnimatedSprite.hpp>
#include <Camera2D.hpp>
#include <Input.hpp>
#include <KinematicBody2D.hpp>

namespace godot
{

class Hero:public KinematicBody2D
{
	GODOT_CLASS(Hero,KinematicBody2D)
private:
	Input *input;
	Vector2 firePos;
	
	float Speed=150,dsTime=0.3F,dsRelTime=1;
	
	int WeaponIndex=0;
	float ChReload,DsReload,dash;
	float health;
	
	Node *WeaponList,*weapon;
	Node2D *DrawingObj;
	AnimatedSprite *AnimationObj;
	Camera2D *Cam;
public:
	static void _register_methods();
	void _init();
	
	Hero();
	~Hero();
	
	void _ready();
	void _input(Variant);
	void _process(float);
	void ChWeapon();
	void Dash();
	void damage(float);
};

}
