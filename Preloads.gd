extends Node

const BULLET = preload("res://Guns/Bullet/Bullet.tscn")
const DROPPED_GUN = preload("res://Guns/GunDroppedTemplate.tscn")

enum GUNS {
	KAR,
	KMG,
	KMULTI,
	KONE,
	KPSTL,
	KREVO,
	KSHORT,
	KSMG
}

const HELD_GUN_LOADS = [
	preload("res://Guns/KAR/KARHeld.tscn"),
	preload("res://Guns/KMG/KMGHeld.tscn"),
	preload("res://Guns/KMULTI/KMULTIHeld.tscn"),
	preload("res://Guns/KONE/KONEHeld.tscn"),
	preload("res://Guns/KPSTL/KPSTLHeld.tscn"),
	preload("res://Guns/KREVO/KREVOHeld.tscn"),
	preload("res://Guns/KSHORT/KSHORTHeld.tscn"),
	preload("res://Guns/KSMG/KSMGHeld.tscn")
]

const ASSET_GUN_LOADS = [
	preload("res://Guns/KAR/Asset/KAR.tscn"),
	preload("res://Guns/KMG/Asset/KMG.tscn"),
	preload("res://Guns/KMULTI/Asset/KMULTI.tscn"),
	preload("res://Guns/KONE/Asset/KONE.tscn"),
	preload("res://Guns/KPSTL/Asset/KPSTL.tscn"),
	preload("res://Guns/KREVO/Asset/KREVO.tscn"),
	preload("res://Guns/KSHORT/Asset/KSHORT.tscn"),
	preload("res://Guns/KSMG/Asset/KSMG.tscn")
]
