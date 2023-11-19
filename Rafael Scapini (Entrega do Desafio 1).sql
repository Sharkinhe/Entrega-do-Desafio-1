create table Clientes (clienteID int unique not null, cliente varchar(40), nomeContato varchar(40), endereco varchar(50), cidade varchar(30), pais varchar(20), paisCodigo varchar(2), regiao varchar(30), cep int, latitude float, longetude float, fax int, telefone int, PRIMARY KEY(clienteID));
create table Produtos (produtoID int unique not null, categoriaID int, produto varchar(30), fornecedorID int);
create table Vendas (cupomID int unique not null, produtoID int, quantidade int, valor float, desconto float, custo float, valorLiquido float, PRIMARY KEY(cupomID), FOREIGN KEY(produtoID) REFERENCES Produtos);
create table Fretes (data date, clienteID int, funcionarioID int, valorFrete float, cupomID int, empresaFrete varchar(30), dataEntrega date, FOREIGN KEY(clienteID) REFERENCES Clientes, FOREIGN KEY(cupomID) REFERENCES Produtos);


--Valor total das vendas e dos fretes por produto e ordem de venda;--
/*Dividindo em cada produtoID e dentro dele ordenando por data, resulta na soma dos valores e fretes por produto*/
select sum(valor), sum(valorFrete)
from Vendas join Fretes on cupomID.Vendas = cupomID.Fretes
group by produtoID
order by data;

--Valor de venda por tipo de produto;--
/*Divindo as vendas por categoriaID e retornando a soma dos valores por categoria do produto*/
select sum(valor)
from Vendas join Produtos on produtoID.Vendas = produtoID.Produtos
group by categoriaID;

--Quantidade e valor das vendas por dia, mês, ano;--
/*Por dia*/
select data, sum(valor)
from Vendas
group by data 
/*Por Mes*/
select year(data), month(data), sum(valor)
from Vendas
group by year(data), month(data);
/*Por Ano*/
select year(data), sum(valor)
from Vendas
group by year(data);

--Lucro dos meses;--
select year(data), month(data), sum(valorLiquido)
from Fretes
group by year(data), month(data);

--Venda por produto;--
select produtoID, sum(valor)
from Vendas
group by produtoID;

--Venda por cliente, cidade do cliente e estado;--
/*Apesar que na tabela cliente não tenha estado, eu acabei optando por deixar como pedido na questão.
Juntei a tabela cliente com frete(pois existe atributo em comum) e com a tabela de vendas(pois precisa de valor e tem atributo em comum com frete)*/
select clienteID, cidade, estado, sum(valor)
from Clientes join Fretes on clienteID.Clientes = clienteID.Fretes
join Vendas on cupomID.Fretes = cupomID.Vendas
group by clienteID, cidade, estado;

--Média de produtos vendidos;--
select avg(valor)
from Vendas;

--Média de compras que um cliente faz;-
select clienteID, avg(valor)
from Clientes join Fretes on clienteID.Clientes = clienteID.Fretes
join Vendas on cupomID.Fretes = cupomID.Vendas
group by clienteID;

