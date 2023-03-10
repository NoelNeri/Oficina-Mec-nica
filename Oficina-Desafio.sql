--  -------------------------------------------------------------------------- Criando o banco de dados e suas tabelas
--  -------------------------------------------------------------------------- Criando o banco de dados e suas tabelas
--  -------------------------------------------------------------------------- Criando o banco de dados e suas tabelas
--  -------------------------------------------------------------------------- Criando o banco de dados e suas tabelas
--  -------------------------------------------------------------------------- Criando o banco de dados e suas tabelas
--  -------------------------------------------------------------------------- Criando o banco de dados e suas tabelas
--  -------------------------------------------------------------------------- Criando o banco de dados e suas tabelas

create database oficmec;
use oficmec;

-- Criar tabela pessoaFisica
create table pessoaFisica(
		pfId int primary key,
		pfNome varchar(45) not null,
		CPF char(11) not null,
		pfDtNasc date not null,
		pfLograd varchar(45) not null,
        pfCEP char(8) not null,
		pfCidade varchar(45) not null,
		pfUF char(2) not null,
		pfTel1 char(11) not null,
		pfTel2 char(11),
		pfEmail1 varchar(45) not null
);

-- Criar tabela pessaoJuridica
create table pessoaJuridica(
		pjId int primary key,
		Razao_social varchar(45) not null,
		NomeFantas varchar(45) not null,
		CNPJ char(14) not null,
		pjContato varchar(45) not null,
		pjTel1 char(11) not null,
		pjTel2 char(11),
		pjEmail varchar(45) not null,
		pjLograd varchar(45) not null,
        pjCEP char(8) not null,
		pjCidade varchar(45) not null,
        pjUF char(2) not null
);

-- Criar tabela Cliente
create table cliente(
		cliid int primary key,
        idpfcli int,
		constraint fk_pf_cli foreign key (idpfcli) references pessoaFisica(pfId),
        idpjcli int,
        constraint fk_pj_cli foreign key (idpjcli) references pessoaJuridica(pjId)
);

-- Criar tabela Veiculo
create table  veiculo(
		velId int primary key,
        idclivel int,
        constraint fk_cli_vel foreign key (idclivel) references cliente(cliid),
        velTipo enum('Moto', 'Carro', 'Triciclo', 'Van', 'Caminh??o') not null,
        velPlaca char(7) not null unique,
        velMarca varchar(45) not null,
        velModelo varchar(45)not null,
        velAno char(4) not null        
);

-- Criar tabela Equipes
create table equipes(
		eqpid int primary key,
		eqpEspec varchar(45) not null,
		idfuneqpResp int not null
);

-- Criar tabela Funcionarios
create table funcionarios(
		funid int primary key,
        idpffun int,
        constraint fk_pf_fun foreign key (idpffun) references pessoaFisica(pfId),
		ideqpfun int,
        constraint fk_eqp_fun foreign key (ideqpfun) references equipes(eqpid),
		funCod char(6) not null,
		funNome varchar(45) not null,
		funCargo varchar(45) not null,
		funEspec varchar(45) not null,
		funDtcont date not null, 
		funTel char(11) not null
);

-- Criar tabela Tabela de Pre??os
create table tabelaPrecos(
		precid int primary key,
		precTipo enum('Conserto','Revis??o') not null,
        precEspec enum('Motor', 'Suspens??o', 'Eletrica', 'Carroceria') not null, 
		precPecas varchar(45),
		precQuant float,
		precPreco float,
		precValServ float not null,
		precValTot float not null
);

-- Criar tabela Estoque de Pe??as
create table estoquepecas(
		estid int primary key,
        estPeca varchar(45) not null,
        estQuant int not null,
        estValUnit float not null,
        idfunestResp int not null,
        constraint fk_fun_estResp foreign key (idfunestResp) references funcionarios(funid)
);

-- Criar tabela Or??amento
create table orcamento(
		orcid int primary key,
        idcliorc int not null,
        constraint fk_cli_orc foreign key (idcliorc) references cliente(cliid),
        idfunorc int not null,
        constraint fk_fun_orc foreign key (idfunorc) references funcionarios(funid),
        orcNum char(8) not null,
        orcAprov enum('Sim','N??o') not null,
        orcDtOrc date not null, 
        orcValOrc float not null,
        orcValid date not null
);

-- Criar tabela Pre??os Or??amento
create table precoOrcamento(
	idorpror int,
	idprecpror int,
	constraint fk_or_pror foreign key (idorpror) references orcamento(orcid),
	constraint fk_prec_pror foreign key (idprecpror) references tabelaPrecos(precid)
);

-- Ordem de Servi??o 
create table ordemservico(
		servid int primary key,
        idvelServ int,
        constraint fk_vel_OrServ foreign key (idvelServ) references veiculo(velId),
        ideqpServ int,
        constraint fk_eqp_OrServ foreign key (ideqpServ) references equipes(eqpid),
        idorcServ int,
        constraint fk_orc_OrServ foreign key (idorcServ) references orcamento(orcid),
        servNum char(8) not null,
        servDtEmiss date not null,
		servPecas varchar(45), 
        servValor float,
        servStatus enum('Em execu????o', 'Concluida', 'Em analise pela equipe','Cancelada'),
        servDtConcl date
);

-- Criar tabela Pecas para ordem de servi??o
create table pecasOS(
        idestpos int,
        constraint fk_est_pos foreign key (idestpos) references estoquepecas(estid),
        idservpos int,
        constraint fk_serv_pos foreign key (idservpos) references ordemservico(servid),
        idorcpos int,
        constraint fk_orc_pos foreign key (idorcpos) references orcamento(orcid)
);






-- ---------------------------------------------------------------------------------------------------------------------------------------- Inserindo dados para persist??ncia
-- ---------------------------------------------------------------------------------------------------------------------------------------- Inserindo dados para persist??ncia
-- ---------------------------------------------------------------------------------------------------------------------------------------- Inserindo dados para persist??ncia
-- ---------------------------------------------------------------------------------------------------------------------------------------- Inserindo dados para persist??ncia
-- ---------------------------------------------------------------------------------------------------------------------------------------- Inserindo dados para persist??ncia
-- ---------------------------------------------------------------------------------------------------------------------------------------- Inserindo dados para persist??ncia
-- ---------------------------------------------------------------------------------------------------------------------------------------- Inserindo dados para persist??ncia



insert into pessoaFisica (pfid, pfNome, CPF, pfDtNasc, pfLograd, pfCEP, pfCidade, pfUF, pfTel1, pfTel2, pfEmail1) values 
		( 1, 'Jo??o Funcionario da Silva 01','12345678901','1970-08-21','Rua dos Bobos n 01', '12345678', 'S??o Paulo','SP','11999112233',null,'joaofun01@gmail.com'),
		( 2, 'Jo??o Funcionario da Silva 02','12345678902','1970-09-22','Rua dos Bobos n 02', '12345678', 'S??o Paulo','SP','11999112232',null,'joaofun02@gmail.com'),
		( 3, 'Jo??o Funcionario da Silva 03','12345678903','1970-10-22','Rua dos Bobos n 03', '12345678', 'S??o Paulo','SP','11999112231',null,'joaofun03@gmail.com'),
		( 4, 'Jo??o Funcionario da Silva 04','12345678904','1970-11-22','Rua dos Bobos n 04', '12345678', 'S??o Paulo','SP','11999112234',null,'joaofun04@gmail.com'),
		( 5, 'Jo??o Funcionario da Silva 05','12345678905','1970-12-22','Rua dos Bobos n 05', '12345678', 'S??o Paulo','SP','11999112235',null,'joaofun05@gmail.com'),
		( 6, 'Jo??o Funcionario da Silva 06','12345678906','1970-09-23','Rua dos Bobos n 06', '12345678', 'S??o Paulo','SP','11999112236',null,'joaofun06@gmail.com'),
		( 7, 'Jo??o Funcionario da Silva 07','12345678907','1970-09-24','Rua dos Bobos n 07', '12345678', 'S??o Paulo','SP','11999112237',null,'joaofun07@gmail.com'),
		( 8, 'Jo??o Cliente da Silva 08','12345678908','1970-09-25','Rua dos Bobos n 08', '12345678', 'S??o Paulo','SP','11999112238',null,'joaocli08@gmail.com'),
		( 9, 'Jo??o Cliente da Silva 09','12345678909','1970-09-26','Rua dos Bobos n 09', '12345678', 'S??o Paulo','SP','11999112239',null,'joaocli09@gmail.com'),
		( 10, 'Jo??o Cliente da Silva 10','12345678910','1970-09-27','Rua dos Bobos n 10', '12345678', 'S??o Paulo','SP','11999112210',null,'joaocli10@gmail.com'),
		( 11, 'Jo??o Cliente da Silva 11','12345678911','1970-09-28','Rua dos Bobos n 11', '12345678', 'S??o Paulo','SP','11999112211',null,'joaocli11@gmail.com');
                
 
insert into pessoaJuridica (pjId, Razao_social, NomeFantas, CNPJ, pjContato, pjTel1, pjTel2, pjEmail, pjLograd, pjCEP, pjCidade, pjUF) values
	 ( 21, 'Empresa Cliente 01 LTDA','Cliente PJ 01','48740351000165','Jos?? do Contato','11998112211','11988002211','empclipj01@empresa.com','Rua das Bobas n 01', '98765323', 'ITU','SP'),
	 ( 22, 'Empresa Cliente 02 LTDA','Cliente PJ 02','48740351000265','Jos?? do Contato','11998112212','11988002212','empclipj02@empresa.com','Rua das Bobas n 02', '98765323', 'ITU','SP'),				
	 ( 23, 'Empresa Cliente 03 LTDA','Cliente PJ 03','48740351000365','Jos?? do Contato','11998112213','11988002213','empclipj03@empresa.com','Rua das Bobas n 03', '98765323', 'ITU','SP'),
	 ( 24, 'Empresa Cliente 04 LTDA','Cliente PJ 04','48740351000465','Jos?? do Contato','11998112214','11988002214','empclipj04@empresa.com','Rua das Bobas n 04', '98765323', 'ITU','SP'),
	 ( 25, 'Empresa Cliente 05 LTDA','Cliente PJ 05','48740351000565','Jos?? do Contato','11998112215','11988002215','empclipj05@empresa.com','Rua das Bobas n 05', '98765323', 'ITU','SP');
                
                
insert into cliente (cliid, idpfcli, idpjcli) values
		(101,1,null),
		(102,2,null),
		(103,3,null),
		(104,4,null),
		(105,5,null),
		(106,6,null),
		(107,7,null),
		(108,8,null),
		(109,9,null),
		(110,10,null),
		(111,11,null),
		(112,null,21),
		(113,null,22),
		(114,null,23),
		(115,null,24),
        (116,null,25);
        

insert into veiculo (velid, idclivel, velTipo, velPlaca, velMarca, velModelo, velAno) values
		(201, 108,'Carro','CHA0B10','FIAT','PALIO','2015'),
		(202, 109,'Van','CHA0B11','HYUNDAI','BEST-A','2018'),
		(203, 110,'Moto','CHA0B12','CALOI','DOBR??VEL','2022'),
		(204, 111,'Carro','CHA0B13','HONDA','ANFIBIO','2020'),
		(205, 112,'CAMINH??O','CHA0C11','FENEMF','BARRIGA','1988'),
		(206, 113,'CAMINH??O','CHA0C12','FENEME','BARRIGB','1988'),
		(207, 114,'CAMINH??O','CHA0C13','FENEMG','BARRIGC','1988'),
		(208, 115,'CAMINH??O','CHA0C14','FENEMH','BARRIGD','1988'),
		(209, 116,'CAMINH??O','CHA0C15','FENEMI','BARRIGE','1988');
		

insert into equipes (eqpid, eqpEspec, idfuneqpResp) values
		(301,'Motor', 4),
		(302,'El??trica', 5),
		(303,'Rodas', 6);


insert into funcionarios (funid, idpffun, ideqpfun, funCod, funNome, funCargo, funEspec, funDtcont, funTel) values 
		(401, 1, 301, '123456', 'Jo??o Funcionario da Silva 01', 'Mec??nico 01', 'Motor Diesel', '2018-02-03', '11977665544'),
		(402, 2, 302, '123446', 'Jo??o Funcionario da Silva 02', 'Eletricista 01', 'Auto Eletricista', '2018-02-03', '11977665544'),
		(403, 3, 303, '123436', 'Jo??o Funcionario da Silva 03', 'Mec??nico 02', 'Rolamentos', '2018-02-03', '11977665544'),
		(404, 4, 301, '123426', 'Jo??o Funcionario da Silva 04', 'Engenheiro Mec??nico', 'Supervisor', '2017-06-03', '11977665544'),
		(405, 5, 302, '123416', 'Jo??o Funcionario da Silva 05', 'Eletricista 02', 'Sonoriza????o', '2018-02-03', '11977665544'),        
		(406, 6, 303, '123406', 'Jo??o Funcionario da Silva 06', 'Mec??nico 03', 'Pneus', '2018-02-03', '11977665544'),        
		(407, 7, 301, '123496', 'Jo??o Funcionario da Silva 07', 'Mec??nico 04', 'Servi??os Gerais', '2018-02-03', '11977665544');
        

insert into tabelaPrecos (precid, precTipo, precEspec, precPecas, precQuant, precPreco, precValServ, precValTot) values
		( 501, 'Conserto','Motor','Ret??dfica',15,13.90,180.00,400.5),
		( 502, 'Conserto','Suspens??o','Suspender',15,13.90,180.00,400.5),
		( 503, 'Conserto','El??trica','Fuz??vel',15,13.90,180.00,400.5),
		( 504, 'Conserto','Carroceria','Funilaria',15,13.90,180.00,400.5),
		( 505, 'Revis??o','Motor','Ret??dfica',15,13.90,180.00,400.5),
		( 506, 'Revis??o','Suspens??o','Suspender',15,13.90,180.00,400.5),
		( 507, 'Revis??o','El??trica','Fuz??vel',15,13.90,180.00,400.5),
		( 508, 'Revis??o','Carroceria','Funilaria',15,13.90,180.00,400.5);
        

insert into estoquepecas (estid, estPeca, estQuant, estValUnit, idfunestResp) values
		( 601, 'Pe??as 01','101', 13.33, 404),
		( 602, 'Pe??as 02','102', 23.33, 404),
		( 603, 'Pe??as 03','103', 33.33, 404),
		( 604, 'Pe??as 04','104', 43.33, 404),
		( 605, 'Pe??as 05','105', 53.33, 404),
		( 606, 'Pe??as 06','106', 63.33, 404),
		( 607, 'Pe??as 07','107', 73.33, 404),
		( 608, 'Pe??as 08','108', 83.33, 404),
		( 609, 'Pe??as 09','109', 93.33, 404),
		( 610, 'Pe??as 10','110', 99.33, 404);
        

insert into orcamento (orcid, idcliorc, idfunorc, orcNum, orcAprov, orcDtOrc, orcValOrc, orcValid) values
		( 701, 108, 401, '98989898', 'Sim', '2020-01-06', 2400.1,'2020-02-06'),
		( 702, 109, 402, '98989897', 'Sim', '2020-01-06', 2402.1,'2020-02-06'),
		( 703, 110, 403, '98989896', 'Sim', '2020-01-06', 2403.1,'2020-02-06'),
		( 704, 111, 405, '98989895', 'Sim', '2020-01-06', 2404.1,'2020-02-06'),
		( 705, 112, 406, '98989894', 'N??o', '2020-01-06', 33000.1,'2020-02-06'),
        ( 706, 113, 407, '98989893', 'Sim', '2020-01-06', 2405.1,'2020-02-06'),
        ( 707, 114, 401, '98989892', 'Sim', '2020-01-06', 2406.1,'2020-02-06'),
        ( 708, 115, 402, '98989891', 'Sim', '2020-01-06', 2407.1,'2020-02-06'),
        ( 709, 116, 403, '98989890', 'Sim', '2020-01-06', 2408.1,'2020-02-06');
        
insert into precoorcamento (idorpror,idprecpror) values
		(701, 501),
        (701, 502),
        (701, 503),
        (701, 504),
        (702, 505),
        (702, 506),
        (702, 507),
        (702, 508),
		(703, 501),
        (703, 502),
        (704, 503),
        (704, 504),
        (705, 505),
        (705, 506),
        (706, 507),
        (706, 508),
		(707, 501),
        (707, 502),
        (707, 503),
        (707, 504),
        (707, 505),
        (707, 506),
        (707, 507),
        (707, 508),
        (708, 508),
        (709, 501),
        (709, 503),
        (709, 505),
        (709, 507);


insert into ordemservico (servid, idvelServ, ideqpServ, idorcServ, servNum, servDtEmiss, servPecas, servValor, servStatus, servDtConcl) values
		( 801, 201, 301, 701, '10000010','2022-01-16', 601, 213.34, 'Concluida','2022-01-20'),
        ( 802, 202, 302, 702, '10000011','2022-01-17', 602, 2212.34, 'Em an??lise pela equipe',null),
        ( 803, 203, 303, 703, '10000012','2022-01-18', 603, 3312.34, 'Em execu????o',null),
        ( 804, 204, 301, 704, '10000013','2022-01-19', 604, 3300.34, 'Cancelada','2022-01-25'),
        ( 805, 205, 302, 705, '10000014','2022-01-20', 605, 3000.00, 'Conclu??da','2022-01-25'),
        ( 806, 206, 303, 706, '10000015','2022-01-20', 605, 4000.00, 'Conclu??da','2022-01-25'),
        ( 807, 207, 301, 707, '10000016','2022-01-20', 605, 5000.00, 'Em execu????o',null),
        ( 808, 208, 302, 708, '10000017','2022-01-20', 605, 6000.00, 'Em execu????o',null),
        ( 809, 209, 303, 709, '10000018','2022-01-20', 605, 7000.00, 'Conclu??da','2022-01-25');
        

insert into pecasos (idestpos, idservpos, idorcpos) values
        (601,801,701),
        (602,801,701),
        (603,801,701),
        (604,801,701),
        (605,801,701),
		(606,802,702),
        (607,802,702),
        (608,802,702),
        (609,802,702),
        (610,802,702),
		(603,803,703),
        (609,803,703),
        (610,803,703),
		(604,804,704),
        (605,804,704),
        (606,804,704),
        (607,804,704),
		(605,805,705),
        (606,805,705),
        (607,805,705),
        (608,805,705),
        (609,805,705),
		(606,806,706),
        (607,806,706),
        (608,806,706),
        (609,806,706),
        (610,806,706),
        (601,806,706),
		(607,807,707),
        (608,807,707),
        (609,807,707),
        (610,807,707),
        (601,807,707),
        (602,807,707),
        (603,807,707),
		(608,808,708),
        (609,808,708),
        (610,808,708),
        (601,808,708),
		(603,809,709),
        (604,809,709);
        
        


    
-- --------------------------------------------------------------------------------------------------------------------------------- Consultas a dados
-- --------------------------------------------------------------------------------------------------------------------------------- Consultas a dados
-- --------------------------------------------------------------------------------------------------------------------------------- Consultas a dados
-- --------------------------------------------------------------------------------------------------------------------------------- Consultas a dados
-- --------------------------------------------------------------------------------------------------------------------------------- Consultas a dados
-- --------------------------------------------------------------------------------------------------------------------------------- Consultas a dados
-- --------------------------------------------------------------------------------------------------------------------------------- Consultas a dados
-- --------------------------------------------------------------------------------------------------------------------------------- Consultas a dados

-- Qual o invent??rio em estoque?
select estPeca, estQuant as Quantidade, estValUnit as 'Valor unit??rio', round((estQuant * estValUnit),2) as 'Valor Total' 
	from estoquepecas 
	order by estPeca;
    

-- Quem s??o os funcion??rios da Oficina Mec??nica e a especialidades de sua equipe?
select funNome, eqpEspec from funcionarios , equipes 
	where ideqpfun = eqpid;


-- Qual(is) os veiculos de cada cliente pessoa Fisica?
select pfNome, velTipo, velMarca, velModelo  from pessoaFisica
		inner join cliente on pfId = idpfcli
        inner join veiculo on cliid = idclivel
        order by pfNome;


-- Qual(is) os veiculos de cada cliente pessoa Juridica?
select Razao_social, velTipo, velMarca, velModelo  from pessoaJuridica
		inner join cliente on pjId = idpjcli
        inner join veiculo on cliid = idclivel
        order by Razao_social;
        
        
-- Quais os clientes possuem carros?
select pfNome, velTipo, velMarca, velModelo  from pessoaFisica
		inner join cliente on pfId = idpfcli
        inner join veiculo on cliid = idclivel
        having velTipo = "Carro"
        order by velMarca;


-- Quantas ordens de servi??os existem?
select count(*) as 'Total de O.S.' from ordemservico;


-- Quantas ordens de servi??os foram Concluidas?
select count(*) as 'O.S. Conclu??das' from ordemservico where servStatus = 'Concluida'; 


-- Quais os valores dos or??amentos por cada Cliente PJ?
select Razao_Social, CNPJ, veltipo 'Tipo', velmarca 'Marca', orcValOrc 'Valor Or??amento', estPeca 'Pe??as no servi??o', 
	   precPreco 'Pre??o de Pe??as', precPecas 'M??o de Obar', precValServ 'Pre??o Mao de Obra' from pessoaJuridica
		inner join cliente on pjId = idpjcli 
        inner join orcamento on cliid = idcliorc
        inner join ordemservico on orcid = idorcServ
        inner join veiculo on idvelServ = velid
        inner join pecasos on idorcpos = orcid
        inner join estoquepecas on idestpos = estid
        inner join precoOrcamento on idorcpos = idorpror
        inner join tabelaprecos on idprecpror = precid;


-- Qual ?? o valor das ordens de servi??os, seus clientes, e ve??culos, al??m dos respectivos or??amentos origin??rios? 
select pfNome, velTipo, velMarca, velModelo, orcNum, servNum, orcValOrc from pessoaFisica
		inner join cliente on pfId = idpfcli
        inner join veiculo on cliid = idclivel
        inner join orcamento on cliid = idcliorc
        inner join ordemservico os on orcid = idorcServ;
        

-- Quai foram os atendimentos conclu??dos da equipe de motor? 
select pfNome, velTipo, velMarca, velModelo, orcNum, servNum, servStatus, eqpEspec, servDtConcl
	from pessoaFisica
		inner join cliente on pfId = idpfcli
        inner join veiculo on cliid = idclivel
        inner join orcamento on cliid = idcliorc
        inner join ordemservico on orcid = idorcserv
        inner join equipes on eqpid = ideqpServ
        having servStatus = 'Concluida' and eqpEspec = 'Motor';
        

-- Qual a produtividade da equipe em Ordem de Servi??os n??o canceladas e o respons??vel por cada equipe?
select servid 'Ordem de Servi??o', funnome, servnum, eqpespec, servdtemiss, servvalor, servstatus from funcionarios
		inner join equipes on idfuneqpResp = idpffun
        inner join ordemservico on ideqpServ = eqpid
        where servstatus <> 'Cancelada'
        order by servid;


-- Quais foram as equipes que atenderam os respectivos ve??culos?
select eqpEspec, velTipo, concat(velMarca, ' | ', velModelo) as Marca_Modelo, velPlaca from equipes
		inner join ordemservico on eqpid = ideqpserv
        inner join veiculo on velId = idvelserv
        order by eqpEspec and velTipo and Marca_Modelo;
        
        

	
-- --------------------------------------------------------------------------------------------------------------------------------- Destruido tudo
-- --------------------------------------------------------------------------------------------------------------------------------- Destruido tudo
-- --------------------------------------------------------------------------------------------------------------------------------- Destruido tudo
-- --------------------------------------------------------------------------------------------------------------------------------- Destruido tudo
-- --------------------------------------------------------------------------------------------------------------------------------- Destruido tudo
-- --------------------------------------------------------------------------------------------------------------------------------- Destruido tudo
-- --------------------------------------------------------------------------------------------------------------------------------- Destruido tudo
    
    
    

    
    
show tables;

drop table pecasos;
drop table ordemservico;
drop table veiculo;
drop table precoorcamento;
drop table orcamento;
drop table cliente;
drop table estoquepecas;
drop table funcionarios;
drop table equipes;
drop table pessoafisica;
drop table pessoajuridica;
drop table tabelaprecos;
drop database oficmec;



        