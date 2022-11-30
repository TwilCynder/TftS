tool

extends Node

class_name FontConfigurator

var advance: Dictionary = {}

func init():
	pass

func largeur_caractere(c: String, largeur: int):
	advance[c.ord_at(0)] = largeur
