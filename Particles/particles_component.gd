extends Node3D

class_name ParticlesComponent

@export var particles: Array[GPUParticles3D]

#@onready var particles: Array[Node3D] = get_children()

var current_particle_index: int = 0

func show_particle(particle_new_position: Vector3) -> void:
	var current_particle: GPUParticles3D
	
	current_particle_index += 1
	current_particle_index %= particles.size()
	current_particle = particles[current_particle_index]
	
	current_particle.global_position = particle_new_position
	current_particle.start_particles()

func get_particle_index(particle: GPUParticles3D) -> int:
	return particles.find(particle)

func clear_particle(particle_index: int) -> void:
	particles[particle_index].set_one_shot(true)

func clear_particles() -> void:
	for particle_index in particles.size():
		clear_particle(particle_index)
