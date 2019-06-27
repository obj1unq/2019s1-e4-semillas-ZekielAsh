class Parcelas {
	const ancho
	const largo
	const property horasQueRecibeLuzSolar
	const property plantas = []
	
	method superficie() = ancho * largo
	
	method cantidadMaximaDePlantas() =
		if (ancho > largo) { self.superficie() / 5 }
		else { self.superficie() / 3 + largo }
		
	method tieneComplicaciones() =	plantas.any{planta =>
		self.toleranciaSolarDe(planta)
	}
	
	method toleranciaSolarDe(planta) = 
		planta.horasDeToleracionSolar() < horasQueRecibeLuzSolar
	
	method plantar(planta) =
		if (plantas.size() == self.cantidadMaximaDePlantas() or 
			(planta.horasDeToleracionSolar() + 2) <= horasQueRecibeLuzSolar){
				self.error("No se puede plantar la planta en la parcela") }
				else { plantas.add(planta) }
	
	method cantidadDePlantas() = plantas.size()
}

class ParcelasEcologicas inherits Parcelas {
	method asociacionDePlantas(planta) =
		planta.parcelaIdeal(self) and not self.tieneComplicaciones()
}

class ParcelasIndustriales inherits Parcelas {
	method asociacionDePlantas(planta) =
		planta.esFuerte() and self.cantidadMaximaDePlantas() == 2
}

object inta {
	const property parcelas = [] 
	
	method aniadirParcelas(parcela) = parcelas.add(parcela)
	
	method promedioDePlantas() = 
		parcelas.sum{parcela => parcela.cantidadDePlantas()} / parcelas.size()
		
	method parcelaMasAutosustentable() { 
		const parcelasAceptables = parcelas.filter{parcela => parcela.cantidadDePlantas() > 4}
		
		return parcelasAceptables.max{
			parcela => parcela.plantas().count{planta => planta.asociaBienEn(parcela)}
		}
	}
}
