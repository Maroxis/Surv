extends Control

func changeDensity(dens):
	self.material.set_shader_param("on1", 0.0)
	self.material.set_shader_param("on2", 0.0)
	self.material.set_shader_param("on3", 0.0)
	self.material.set_shader_param("light", 0.8-0.02*dens*dens)
	if(dens >= Global.Weather.type.Rain):
		self.material.set_shader_param("on1", 1.0)
	if(dens >= Global.Weather.type.HeavyRain):
		self.material.set_shader_param("on2", 1.0)
	if(dens >= Global.Weather.type.Storm):
		self.material.set_shader_param("on3", 1.0)
	
func show():
	self.visible = true

func hide():
	self.visible = false
