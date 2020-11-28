program examen;

const
  cSucursales = 5;

type
  rSucursales = 1..cSucursales;

  regVenta = record
    codigo : integer;
    cantidad : integer;
    monto : real;
  end;

  regTotal = record
    codigo : integer;
    monto : double;
  end;

  listaVentasPtr = ^nodoVenta;

  nodoVenta = record
    dato : regVenta;
    sig : listaVentasPtr;
  end;

  listaTotalPtr = ^nodoTotal;

  nodoTotal = record
    dato : regTotal;
    sig : listaTotalPtr;
  end;

  arrSucursales = array[rSucursales] of listaVentasPtr;

procedure leerVenta(var venta : regVenta);
begin
  with venta do begin
    writeln('codigo');
    readln(codigo);
    if (codigo <> -1) then begin
      readln(cantidad);
      readln(monto);
    end;
  end;
end;

procedure inicializar(var sucursales : arrSucursales);
var i : integer;
begin
  for i := 1 to cSucursales do
    sucursales[i] := nil;
end;

procedure guardar(var lista, ult : listaVentasPtr; venta : regVenta);
var
  nodo : listaVentasPtr;
begin
  new(nodo);
  nodo^.dato := venta;
  nodo^.sig := nil;

  if (lista = nil) then
    lista := nodo
  else
    ult^.sig := nodo;
  ult := nodo;
end;

procedure leerVentas(var listaVentas : listaVentasPtr);
var
  venta : regVenta;
  cantidad : integer;
  ult : listaVentasPtr;
begin
  ult := nil;
  cantidad := 0;
  leerVenta(venta);
  while ((venta.codigo <> -1) and (cantidad < 5)) do begin
    guardar(listaVentas, ult, venta);
    cantidad := cantidad + 1;
    leerVenta(venta);
  end;
end;

procedure leerVentasSucursales(var sucursales : arrSucursales);
var i : integer;
begin
  for i := 1 to cSucursales do
    leerVentas(sucursales[i]);
end;

procedure minimo(var sucursales : arrSucursales; var min : regVenta);
var i, indiceMin : integer;
begin
  min.codigo := 32767;
  indiceMin := -1;
  for i := 1 to cSucursales do begin
    if (sucursales[i] <> nil) then begin
      if (sucursales[i]^.dato.codigo < min.codigo) then begin
        min := sucursales[i]^.dato;
        indiceMin := i;
      end;
    end;
  end;

  if (indiceMin <> -1) then begin
    sucursales[indiceMin] := sucursales[indiceMin]^.sig;
  end;
end;

procedure agregarTotal(var listaNueva, ult : listaTotalPtr; total : regTotal);
var
  nodo : listaTotalPtr;
begin
  new(nodo);
  nodo^.dato := total;
  nodo^.sig := nil;

  if (listaNueva = nil) then
    listaNueva := nodo
  else
    ult^.sig := nodo;
  ult := nodo;
end;

procedure merge(sucursales : arrSucursales; var listaNueva : listaTotalPtr);
var
  min : regVenta;
  codAct : integer;
  totalActual : regTotal;
  ult : listaTotalPtr;
begin
  listaNueva := nil; ult := nil;
  minimo(sucursales, min);
  while (min.codigo <> 32767) do begin
    codAct := min.codigo;
    totalActual.monto := 0;
    totalActual.codigo := codAct;
    while ((min.codigo <> 32767) and (min.codigo = codAct)) do begin
      totalActual.monto := totalActual.monto + min.monto;
      minimo(sucursales, min);
    end;
    agregarTotal(listaNueva, ult, totalActual);
  end;
end;

procedure obtenerCantidad(lista : listaTotalPtr; var cantidadProdMontoMenor : integer);
begin
  if (lista <> nil) then begin
    if (lista^.dato.monto < 300000) then
      cantidadProdMontoMenor := cantidadProdMontoMenor + 1;
    obtenerCantidad(lista^.sig, cantidadProdMontoMenor);
  end;
end;

procedure imprimirLista(lista : listaVentasPtr);
begin
  while (lista <> nil) do begin
    writeln(lista^.dato.codigo);
    lista := lista^.sig;
  end;
end;

procedure imprimirArr(sucursales : arrSucursales);
var i : integer;
begin
  for i := 1 to cSucursales do begin
    writeln('Sucursal ', i);
    imprimirLista(sucursales[i]);
  end;
end;

procedure imprimirLista2(lista : listaTotalPtr);
begin
  while (lista <> nil) do begin
    writeln(lista^.dato.codigo);
    writeln(lista^.dato.monto);
    lista := lista^.sig;
  end;
end;

var
  sucursales : arrSucursales;
  listaProductos : listaTotalPtr;
  cantidadProdMontoMenor : integer;
begin
  inicializar(sucursales);
  leerVentasSucursales(sucursales);
  imprimirArr(sucursales);
  merge(sucursales, listaProductos);
  imprimirLista2(listaProductos);
  cantidadProdMontoMenor := 0;
  obtenerCantidad(listaProductos, cantidadProdMontoMenor);
  writeln('cantidad: ', cantidadProdMontoMenor);
  readln;
end.
