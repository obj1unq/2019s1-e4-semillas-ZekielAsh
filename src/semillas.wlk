class Plantas {
	const property anioDeObtencion
	const property altura
	
	method horasDeToleracionSolar() = 0
	
	method esFuerte()= self.horasDeToleracionSolar() > 10 
	
	method asociaBienEn(parcela) = parcela.asociacionDePlantas(self)
}

class Menta inherits Plantas {
	override method horasDeToleracionSolar() = 6
	
	method daNuevasSemillas() = 
		self.esFuerte() or self.altura() > 0.4
		
	method espacioOcupado() = self.altura() * 3
	
	method parcelaIdeal(parcela) = parcela.superficie() > 6 
	
}

class Soja inherits Plantas {
	override method horasDeToleracionSolar() = 
			if (self.altura() > 1) { 9 }
			else if (self.altura() > 0.5 ) { 7 }
			else { 6 }
	
	method daNuevasSemillas() = 
		self.esFuerte() or (self.anioDeObtencion() >= 2007 and self.altura() > 1)
	
	method espacioOcupado() = self.altura() / 2
	
	method parcelaIdeal(parcela) {
		return parcela.horasQueRecibeLuzSolar() == self.horasDeToleracionSolar()}
}

class Quinoa inherits Plantas {
	const property horasDeToleracionSolar
	
	method daNuevasSemillas() = 
		self.esFuerte() or self.anioDeObtencion() < 2005
	
	method espacioOcupado() = 0.5
	
	method parcelaIdeal(parcela) = 
		parcela.plantas().all({planta => planta.altura() <= 1.5})
}

class SojaTransgenica inherits Soja {
	override method daNuevasSemillas() = false
	
	override method parcelaIdeal(parcela) = 
		parcela.cantidadMaximaDePlantas() == 1
}

class HierbaBuena inherits Menta {
	override method espacioOcupado() = (self.altura() * 3) *2
}