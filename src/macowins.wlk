class Prenda{
	var property precioBase;
	var property tipoProducto; //saco/pantalon/camisa
	var property estadoPrenda;
	
	method calcularPrecio() {
		return self.estadoPrenda().calcularPrecio(self.precioBase());
	}
}

class EstadoPrenda{ 
	method calcularPrecio(precio){
		return precio;
	}
}

class NuevaPrenda inherits EstadoPrenda{
	
}

class PromocionPrenda inherits EstadoPrenda{
	var property valorFijo = 10;
	override method calcularPrecio(precio){		
		return precio - valorFijo;
	}
}

class LiquidacionPrenda inherits EstadoPrenda{
	override method calcularPrecio(precio){		
		return precio / 2;
	}
}


class Venta{
	var property fecha;
	var property prendas;
	var property tipoPago; //efectivo/tarjeta
		
	method calcularSubTotal(){
		return prendas.sum{p => p.calcularPrecio()}
	}
	
	method calcularTotal(){
		self.tipoPago().calcularTotal(1, self); //le estoy dando un valor por defecto, donde en este caso es de 1 cuota)
	}
	
}

class TipoDePago{
	
	method calcularTotal(cantidadCuotas,venta);
	
}

class Efectivo inherits TipoDePago{
	override method calcularTotal(cantidadCuotas,venta){
		return venta.calcularSubTotal()
	}
}

class Tarjeta inherits TipoDePago{
	var property coeficienteFijo = 3;
	override method calcularTotal(cantidadCuotas,venta){
		return venta.calcularSubTotal() + 
		(cantidadCuotas * coeficienteFijo + venta.prendas().forEach(0.01 * venta.prendas().precioBase()))
	}
}

class RegistroVenta{
	var property ventas
	
	method gananciaDelDia(fecha){
		return ventas.filter{v => v.fecha() == fecha}.sum{v => v.calcularTotal()}
	}
}