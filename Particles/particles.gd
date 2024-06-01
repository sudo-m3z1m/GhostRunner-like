extends GPUParticles3D

class_name Particles

@export var additional_particles: Array[GPUParticles3D]

func start_particles() -> void:
	restart()
	for particle in additional_particles:
		particle.restart()

func finish_particles() -> void:
	pass
