-- Portfolio - Database Modeling & SQL / NoSQL

# Criação da base de dados
create database db_sistema_universidade;
use db_sistema_universidade;

# Criação das tabelas com os seus relacionamentos
-- Tabela Curso
create table tbl_curso
(
id_curso int not null primary key auto_increment,
nome varchar (30) not null,
area varchar (30) not null,
tipo varchar (30) not null,
modalidade varchar(30) not null, 
duracao varchar (10) not null,
unique index (id_curso)
);

-- Tabela Turma, já recebendo a fk vinda de tbl_curso
create table tbl_turma
(
id_turma int not null primary key auto_increment,
codigo_turma varchar (20) not null,
id_curso int not null,
unique index (id_turma),
constraint fk_curso_turma foreign key (id_curso) references tbl_curso (id_curso)
);

-- Tabela Lista, recebendo a fk vinda de tbl_turma
create table tbl_lista
(
id_lista int not null primary key auto_increment, 
data_lista date not null,
id_turma int not null,
constraint fk_turma_lista foreign key (id_turma) references tbl_turma (id_turma),
unique index (id_lista)
);

-- Tabela Aluno, com as outras tabelas que armazenam dados dos alunos
create table tbl_aluno
(
id_aluno int not null primary key auto_increment, 
ra varchar (10) not null,
senha varchar (10) not null,
nome varchar (45) not null, 
data_nascimento date not null,
id_turma int not null,
constraint fk_turma_aluno foreign key (id_turma) references tbl_turma (id_turma),
unique index (id_aluno)
);

-- Tabela Responsável por armazenar a presença do aluno
create table tbl_lista_aluno
(
id_lista_aluno int not null primary key auto_increment,
id_aluno int not null,
id_lista int not null,
status_aluno varchar (20) not null,
constraint fk_aluno_lista_aluno foreign key (id_aluno) references tbl_aluno (id_aluno),
constraint fk_lista_lista_aluno foreign key (id_lista) references tbl_lista (id_lista),
unique index (id_lista_aluno)
);

-- Tabela Email do Aluno
create table tbl_email_aluno
(
id_email_aluno int not null primary key auto_increment,
id_aluno int not null,
email_aluno varchar (45) not null,
constraint fk_aluno_email_aluno foreign key (id_aluno) references tbl_aluno (id_aluno)
);

-- Tabela Endereço do Aluno
create table tbl_endereco_aluno
(
id_endereco_aluno int not null primary key auto_increment,
logradouro varchar (45) not null,
numero varchar (10) not null,
complemento varchar (30) not null,
bairro varchar (30) not null,
cidade varchar (30) not null,
cep varchar (10) not null, 
id_aluno int not null,
constraint fk_aluno_endereco_aluno foreign key (id_aluno) references tbl_aluno (id_aluno),
unique index (id_endereco_aluno)
);

-- Tabela Telefone do Aluno
create table tbl_telefone_aluno
(
id_telefone_aluno int not null primary key auto_increment,
telefone_aluno varchar (20) not null,
id_aluno int not null,
constraint fk_aluno_telefone_aluno foreign key (id_aluno) references tbl_aluno (id_aluno),
unique index (id_telefone_aluno)
);

-- Tabela Nota
create table tbl_nota
(
id_nota int not null primary key auto_increment,
nota varchar (5) not null,
tipo varchar (20) not null,
unique index (id_nota)
);

-- Tabela aluno_nota - para atrelar uma nota especifica a um aluno especifico
create table tbl_aluno_nota
(
id_aluno_nota int not null primary key auto_increment,
id_aluno int not null,
id_nota int not null,
constraint fk_aluno_aluno_nota foreign key (id_aluno) references tbl_aluno (id_aluno),
constraint fk_nota_aluno_nota foreign key (id_nota) references tbl_nota (id_nota),
unique index (id_aluno_nota)
);

-- Tabela Disciplina
create table tbl_disciplina
(
id_disciplina int not null primary key auto_increment,
nome varchar (45) not null,
unique index (id_disciplina)
);

-- Adicionando novo campo a tabela lista, para criar a relação da lista com a disciplina
alter table tbl_lista add column id_disciplina int not null;

-- Tornando o novo campo criado, como chave estrangeira, da tabela disciplina.
alter table tbl_lista add constraint fk_disciplina_lista foreign key (id_disciplina) references tbl_disciplina (id_disciplina);

-- Tabela nota_disciplina, para atrelar uma nota específica a uma disciplina
create table tbl_nota_disciplina
(
id_nota_disciplina int not null primary key auto_increment,
id_nota int not null,
id_disciplina int not null,
constraint fk_nota_nota_disciplina foreign key (id_nota) references tbl_nota (id_nota),
constraint fk_disciplina_nota_disciplina foreign key (id_disciplina) references tbl_disciplina (id_disciplina),
unique index (id_nota_disciplina)
);

-- Tabela curso_disciplina, para atrelar uma disciplina a um curso
create table tbl_curso_disciplina 
(
id_curso_disciplina int not null primary key auto_increment,
id_curso int not null,
id_disciplina int not null,
constraint fk_curso_curso_disciplina foreign key (id_curso) references tbl_curso (id_curso),
constraint fk_disciplina_curso_disciplina foreign key (id_disciplina) references tbl_disciplina (id_disciplina),
unique index (id_curso_disciplina)
);

-- Tabela Professor
create table tbl_professor
(
id_professor int not null primary key auto_increment, 
ra varchar (10) not null,
senha varchar (10) not null,
nome varchar (45) not null,
data_nascimento date not null,
unique index (id_professor)
);

-- Adicionando o campo id_professor como chave estrangeira na tabela disciplina
alter table tbl_disciplina add column id_professor int not null;
alter table tbl_disciplina add constraint fk_disciplina_professor foreign key (id_professor) references
tbl_professor (id_professor);

-- Tabela Telefone_professor
create table tbl_telefone_professor
(
id_telefone_professor int not null primary key auto_increment,
telefone_professor varchar (20) not null,
id_professor int not null,
constraint fk_professor_telefone_professor foreign key (id_professor) references tbl_professor (id_professor),
unique index (id_telefone_professor)
);

create table tbl_email_professor
(
id_email_professor int not null primary key auto_increment,
email_professor varchar (45) not null,
id_professor int not null,
constraint fk_professor_email_professor foreign key (id_professor) references tbl_professor (id_professor),
unique index (id_email_professor)
);

create table tbl_endereco_professor
(
id_endereco_professor int not null primary key auto_increment,
logradouro varchar (45) not null,
numero varchar (10) not null,
complemento varchar (30) not null,
bairro varchar (30) not null,
cidade varchar (30) not null,
cep varchar (10) not null,
id_professor int not null,
constraint fk_professor_endereco_professor foreign key (id_professor) references tbl_professor (id_professor),
unique index (id_endereco_professor)
);

-- Alterando o tamanho dos campos nome e duracao
alter table tbl_curso modify column nome varchar (45);
alter table tbl_curso change column duracao duracao varchar (15);

-- Inserindo os registros nas tabelas
# Tabela Curso - area de tecnologia
insert into tbl_curso (nome, area, tipo, modalidade, duracao) values 
('Análise e Desenvolvimento de Sistemas', 'Tecnologia', 'Graduação Tecnológica', 'Presencial', '4 Semestres'),
('Redes de Computadores', 'Tecnologia', 'Graduação Tecnológica', 'Presencial', '4 Semestres'),
('Ciencia de Dados', 'Tecnologia', 'Graduação Tecnológica', 'Presencial', '4 Semestres'),
('Segurança da Informação', 'Tecnologia', 'Bacharelado', 'Presencial', '6 Semestres');
select * from tbl_curso;

# Tabela Curso - area de saude
insert into tbl_curso (nome, area, tipo, modalidade, duracao) values
('Medicina', 'Saúde', 'Graduação', 'Presencial', '10 semestres'),
('Enfermagem', 'Saúde', 'Graduação', 'Presencial', '10 semestres'),
('Fisioterapia', 'Saúde', 'Graduação', 'Presencial', '8 semestres'),
('Fonoaudiologia', 'Saúde', 'Graduação', 'Presencial', '8 semestres');
select * from tbl_curso;

# Tabela Professor
insert into tbl_professor (ra, senha, nome, data_nascimento) values
('12345', '12345', 'Sergio da Silva', '1990-09-12'),
('23456', '23456', 'Ana Oliveira', '1985-11-01'),
('34567', '34567', 'Paulo Goncalves', '1995-01-25'),
('45678', '45678', 'Thiago Ferreira', '1980-12-25'),
('56789', '56789', 'Carla Silva', '1976-03-31');
select * from tbl_professor;

# Tabela - Email do professor
insert into tbl_email_professor (email_professor, id_professor) values
('sergio.silva@universidade.com.br', 1),
('ana.oliveira@universidade.com.br', 2),
('paulo.goncalves@universidade.com.br', 3),
('thiago.ferreira@universidade.com.br', 4),
('carla.silva@universidade.com.br', 5);
select * from tbl_email_professor;

# Tabela - Endereço do Professor
insert into tbl_endereco_professor (logradouro, numero, complemento, bairro, cidade, cep, id_professor) values
('Rua dos Bananais', '1266-A', 'Sem complemento', 'Jardim das Oliveiras', 'Osasco', '12345-000', 1),
('Avenida Silva e Silva', '553', 'Edificio Villa Central', 'Centro', 'Barueri', '23456-100', 2),
('Rodovia dos Bandeirantes', 'km02 1567', 'Res. Villa São Paulo T12 Ap 04', 'Centro', 'Caieiras', '34567-000', 3),
('Estrada do Capuava', '810', 'Sitio do Sossego', 'Capuava', 'Embu das Artes', '45678-000', 4),
('Avenida Cidade Taboao', '9011', 'Condominio Jardim Laguna', 'Jardim Laguna', 'Taboão Da Serra', '56789-000', 5);
select * from tbl_endereco_professor;

# Tabela - Telefone do Professor
insert into tbl_telefone_professor (telefone_professor, id_professor) values
('11-91234-5671', 1),
('11-91234-5672', 2),
('11-91234-5673', 3),
('11-91234-5674', 4),
('11-91234-5675', 5);
select * from tbl_telefone_professor;

# Visualização de todos os dados dos professores
select tbl_professor.ra, tbl_professor.senha, tbl_professor.nome, tbl_professor.data_nascimento, 
tbl_telefone_professor.telefone_professor, tbl_email_professor.email_professor, 
tbl_endereco_professor.logradouro, tbl_endereco_professor.numero, tbl_endereco_professor.complemento, 
tbl_endereco_professor.bairro, tbl_endereco_professor.cidade, tbl_endereco_professor.cep
from tbl_professor inner join tbl_endereco_professor on tbl_professor.id_professor = tbl_endereco_professor.id_professor
inner join tbl_email_professor on tbl_professor.id_professor = tbl_email_professor.id_professor
inner join tbl_telefone_professor on tbl_professor.id_professor = tbl_endereco_professor.id_professor;

# Tabela Turma
select * from tbl_turma;
select * from tbl_curso;
insert into tbl_turma (codigo_turma, id_curso) values
('2025ADS1', 1),
('2025RDC1', 2),
('2025CD1', 3),
('2025SEGINF1', 4),
('2025MED1', 5),
('2025ENF1', 6),
('2025FST1', 7),
('2025SFNG1', 8);

# Cursos e suas respectivas turmas
select tbl_curso.nome, tbl_turma.codigo_turma as turma from tbl_curso 
inner join tbl_turma on tbl_curso.id_curso = tbl_turma.id_curso;

# Tabela Aluno
insert into tbl_aluno (ra, senha, nome, data_nascimento, id_turma) values
('12345', '12345', 'Paulo da Silva', '1990-09-17', 1),
('12346', '12346', 'Ana Souza', '1989-11-30', 1),
('12347', '12347', 'Gabriel Silva', '1998-01-01', 1),
('12348', '12348', 'Daniel Moura', '1999-03-31', 2),
('12349', '12349', 'Vitoria Souza', '1985-08-24', 2),
('12350', '12350', 'Maite Lourenço', '1992-04-05', 2),
('12351', '12351', 'Thiago Cesar Chaves', '1983-05-01', 3),
('12352', '12352', 'Ana Livia', '2000-06-17', 3),
('12353', '12353', 'Andre Silva', '2001-07-29', 3),
('12354', '12354', 'Luciano Souza de Oliveira', '1989-09-01', 4),
('12355', '12355', 'Ana Paula da Silva', '2002-10-10', 4),
('12356', '12356', 'Cesar Augusto Nascimento', '1993-08-20', 4),
('12357', '12357', 'Paulo Marinho', '1996-12-31', 5),
('12358', '12358', 'Clara Silva', '1991-05-15', 5),
('12359', '12359', 'Daniel Santos', '1988-10-10', 5),
('12360', '12360', 'Erika Martins', '1996-04-25', 6),
('12361', '12362', 'Felipe Pereira', '1982-07-08', 6),
('12362', '12362', 'Gabriela Costa', '1999-11-19', 6),
('12363', '12363', 'Hugo Almeida', '1980-12-12', 7),
('12364', '12364', 'Laura Ferreira', '2003-03-30', 7),
('12365', '12365', 'Otávio Carvalho', '1995-07-21', 7),
('12366', '12366', 'Natalia Barbosa', '1989-12-09', 8),
('12367', '12367', 'Vitoria Dias', '1983-05-04', 8),
('12368', '12368', 'William Rocha', '1994-09-18', 8);
select tbl_aluno.nome from tbl_aluno;
select * from tbl_aluno;

# Email do Aluno
insert into tbl_email_aluno (email_aluno, id_aluno) values
('paulo.da.silva@universidade.com.br', 1),
('ana.souza@universidade.com.br', 2),
('gabriel.silva@universidade.com.br', 3),
('daniel.moura@universidade.com.br', 4),
('vitoria.souza@universidade.com.br', 5),
('maite.lourenco@universidade.com.br', 6),
('thiago.chaves@universidade.com.br', 7),
('ana.livia@universidade.com.br', 8),
('andre.silva@universidade.com.br', 9),
('luciano.souza@universidade.com.br', 10),
('ana.paula.silva@universidade.com.br', 11),
('cesar.augusto@universidade.com.br', 12),
('paulo.marinho@universidade.com.br', 13),
('clara.silva@universidade.com.br', 14),
('daniel.santos@universidade.com.br', 15),
('erika.martins@universidade.com.br', 16),
('felipe.pereira@universidade.com.br',17),
('gabriela.costa@universidade.com.br', 18),
('hugo.almeida@universidade.com.br', 19),
('laura.ferreira@universidade.com.br', 20),
('otavio.carvalho@universidade.com.br', 21),
('natalia.barbosa@universidade.com.br', 22),
('vitoria.dias@universidade.com.br', 23),
('william.rocha@universidade.com.br', 24);
select * from tbl_email_aluno;
select count(email_aluno) from tbl_email_aluno;

# Tabela Endereco do Aluno
select tbl_aluno.id_aluno, tbl_aluno.nome from tbl_aluno;
insert into tbl_endereco_aluno (logradouro, numero, complemento, bairro, cidade, cep, id_aluno) values
('Rua das Palmeiras', '789', 'Casa A', 'Jardim Botânico', 'Campinas', '13092-234', 1),
('Avenida Ibirapuera', '1234', 'Apartamento 5B', 'Moema', 'São Paulo', '04029-000', 2),
('Estrada do Vinho', '5678', 'Lote 12', 'Pousada da Colina', 'São Roque', '18130-000', 3),
('Rodovia Anhanguera', 'KM 105', 'Lote 3', 'Distrito Industrial', 'Americana', '13473-100', 4),
('Rua da Consolação', '210', 'Apartamento 15', 'Consolação', 'São Paulo', '01301-100', 5),
('Avenida Brasil', '987', 'Casa C', 'Vila Ana', 'Jundiaí', '13208-050', 6),
('Estrada de Parelheiros', '3456', 'Sítio Recanto Feliz', 'Parelheiros', 'São Paulo', '04890-000', 7),
('Rodovia Raposo Tavares', 'KM22 12900', 'Lote 5', 'Granja Viana', 'Cotia', '06700-000', 8),
('Rua XV de Novembro', '56', 'Apartamento 2', 'Centro', 'Santos', '11010-150', 9),
('Avenida Paulista', '1800', 'Conjunto 201', 'Bela Vista', 'São Paulo', '01310-200', 10),
('Estrada do MBoi Mirim', '7890', 'Casa 1', 'Jardim Ângela', 'São Paulo', '04940-000', 11),
('Rodovia Dom Pedro I', 'KM 130 667', 'Chácara do Sol', 'Sousas', 'Campinas', '13105-800', 12),
('Rua Barão de Itapetininga', '45', 'Apartamento 32', 'Centro', 'São Paulo', '01042-000', 13),
('Avenida Brigadeiro Faria Lima', '2500', 'Sala 10', 'Itaim Bibi', 'São Jose do Rio Preto', '01451-000', 14),
('Estrada de Itapecerica', 901, 'Casa 4', 'Jardim São Francisco', 'Itapecerica da Serra', '06850-000', 15),
('Rodovia Ayrton Senna', 'KM 40', 'Lote 7', 'Arujazinho', 'Arujá', '07400-000', 16),
('Rua Augusta', '1500', 'Loja 1', 'Cerqueira César', 'São Paulo', '01305-100', 17),
('Avenida Senador Feijó', '333', 'Conjunto 12', 'Gonzaga', 'Santos', '11015-500', 18),
('Estrada do Campo Limpo', '123', 'Bloco C', 'Jardim Taboão', 'Taboão da Serra', '06764-000', 19),
('Rodovia Castelo Branco', 'KM 65', 'Galpão A', 'São João', 'Mairinque', '18140-000', 20),
('Rua Vinte e Cinco de Março', '100', 'Loja 50', 'Centro', 'São Paulo', '01021-000', 21),
('Avenida Santos Dumont', '789', 'Casa B', 'Jardim Aeroporto', 'Guarulhos', '07180-000', 22),
('Estrada de Mogi das Cruzes', '234', 'Casa de Praia', 'Riviera de São Lourenço', 'Bertioga', '11250-000', 23),
('Rodovia dos Imigrantes', 'KM 28', 'Sítio das Flores', 'Eldorado', 'Diadema', '09970-000', 24);
select * from tbl_endereco_aluno;
select tbl_aluno.id_aluno, tbl_aluno.nome, tbl_endereco_aluno.logradouro, tbl_endereco_aluno.numero, 
tbl_endereco_aluno.complemento, tbl_endereco_aluno.bairro, tbl_endereco_aluno.cidade, 
tbl_endereco_aluno.cep from tbl_aluno inner join tbl_endereco_aluno
on tbl_aluno.id_aluno = tbl_endereco_aluno.id_aluno;

select * from tbl_telefone_aluno;
# Telefone do Aluno
insert into tbl_telefone_aluno (telefone_aluno, id_aluno) values
('11987654321', 1),
('11987654322', 2),
('11987654323', 3),
('11987654324', 4),
('11987654325', 5),
('11987654326', 6),
('11987654327', 7),
('11987654328', 8),
('11987654329', 9),
('11987654330', 10),
('11987654331', 11),
('11987654332', 12),
('11987654333', 13),
('11987654334', 14),
('11987654335', 15),
('11987654336', 16),
('11987654337', 17),
('11987654338', 18),
('11987654339', 19),
('11987654340', 20),
('11987654341', 21),
('11987654342', 22),
('11987654343', 23),
('11987654344', 24);

# Mostrando todos os dados dos alunos, juntamente com o curso e a turma a qual estes pertencem
select tbl_aluno.ra, tbl_aluno.senha, tbl_aluno.nome, tbl_aluno.data_nascimento, 
tbl_endereco_aluno.logradouro, tbl_endereco_aluno.numero, tbl_endereco_aluno.complemento, 
tbl_endereco_aluno.bairro, tbl_endereco_aluno.cidade, tbl_endereco_aluno.cep,
tbl_telefone_aluno.telefone_aluno, tbl_email_aluno.email_aluno, tbl_turma.codigo_turma,
tbl_curso.nome
from tbl_aluno inner join tbl_endereco_aluno on tbl_aluno.id_aluno = tbl_endereco_aluno.id_aluno
inner join tbl_telefone_aluno on tbl_aluno.id_aluno = tbl_telefone_aluno.id_aluno
inner join tbl_email_aluno on tbl_aluno.id_aluno = tbl_email_aluno.id_aluno
inner join tbl_turma on tbl_turma.id_turma = tbl_aluno.id_turma
inner join tbl_curso on tbl_curso.id_curso = tbl_turma.id_curso;


# Tabela Disciplina
select * from tbl_disciplina;
select tbl_professor.id_professor, tbl_professor.nome from tbl_professor;

insert into tbl_disciplina (nome, id_professor) values
('Lógica de Programação I', 1),
('Lógica de Programação II', 1),
('Programação Web I', 1),
('Programação Web II', 1),
('Banco de Dados I', 1),
('Banco de Dados', 1),
('Lógica Matemática', 2),
('Estatística I', 2),
('Estatística II', 2),
('Introdução ao Cálculo', 2),
('Cálculo I', 2),
('Calculo II', 2);

# Alimentar as disciplinas da area da saude com os professores restantes. 
insert into tbl_disciplina (nome, id_professor) values
('Anatomia Humana', 3),
('Fisiologia', 3),
('Bioquímica', 3),
('Microbiologia', 4),
('Imunologia', 4),
('Genética', 4),
('Cinesiologia e Biomecânica', 5),
('Recursos Terapêuticos Manuais', 5),
('Eletrotermofototerapia', 5);

# Inserindo mais disciplinas para os cursos de tecnologia
insert into tbl_disciplina (nome, id_professor) values
('Estatística e Probabilidade', 1),
('Aprendizado de Máquina (Machine Learning)', 1),
('Visualização de Dados', 1),
('Mineração de Dados', 2),
('Análise de Big Data', 2),
('Ética em Dados', 2);

# Checando as disciplinas salvas
select * from tbl_disciplina;

# Estabelecendo a relação entre os cursos, e as disciplinas
select tbl_curso.id_curso, tbl_curso.nome from tbl_curso;
select tbl_disciplina.id_disciplina, tbl_disciplina.nome from tbl_disciplina;

# Relacionando os cursos e as disciplinas de tecnologia
insert into tbl_curso_disciplina (id_curso, id_disciplina) values
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 10), (1, 11), (1, 12),
(2, 1), (2, 2), (2, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10), (2, 11), (2, 12),
(3, 1), (3, 2), (3, 5), (3, 6), (3, 7), (3, 8), (3, 9), (3, 10), (3, 11), (3, 12),
(3, 22), (3, 23), (3, 24), (3, 25), (3, 26), (3, 27),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 8), (4, 9), (4, 10), 
(4, 11), (4, 12);

# Relacionando os cursos e as disciplinas de saude - construir a relação
select tbl_curso.id_curso, tbl_curso.nome from tbl_curso where id_curso > 4;
select tbl_disciplina.id_disciplina, tbl_disciplina.nome from tbl_disciplina where id_disciplina > 12 and id_disciplina < 22; 

insert into tbl_curso_disciplina (id_curso, id_disciplina) values
(5, 13), (5, 14), (5, 15), (5, 16), (5, 17), (5, 18),
(6, 13), (6, 14), (6, 15), (6, 16), (6, 17), (6, 18), (6, 19), (6, 20), 
(6, 13), (6, 14), (6, 15), (6, 16), (6, 17), (6, 18), (6, 20), (6, 21);
select * from tbl_curso_disciplina;

# Mostrando os cursos com as suas disciplinas
select tbl_curso.nome, tbl_curso.area, tbl_curso.tipo, tbl_curso.modalidade, tbl_curso.duracao, tbl_disciplina.nome from tbl_curso 
inner join tbl_curso_disciplina on tbl_curso.id_curso = tbl_curso_disciplina.id_curso
inner join tbl_disciplina on tbl_disciplina.id_disciplina = tbl_curso_disciplina.id_disciplina;

# Construindo a lista de presenca para uma turma
select tbl_turma.codigo_turma, tbl_curso.nome from tbl_turma inner join tbl_curso on tbl_curso.id_curso = tbl_turma.id_curso;

select tbl_disciplina.id_disciplina, tbl_disciplina.nome, tbl_curso.id_curso, tbl_curso.nome from tbl_curso 
inner join tbl_curso_disciplina on tbl_curso.id_curso = tbl_curso_disciplina.id_curso 
inner join tbl_disciplina on tbl_disciplina.id_disciplina = tbl_curso_disciplina.id_disciplina;

# Gerando o id da lista para cada turma
insert into tbl_lista (data_lista, id_turma, id_disciplina) values
('2025-09-15', 1, 1), ('2025-09-16', 2, 1), ('2025-09-17', 3, 1), ('2025-09-18', 4, 1), ('2025-09-19', 5, 13),
('2025-09-15', 6, 13), ('2025-09-18', 7, 13), ('2025-09-19', 8, 13);
select * from tbl_lista;

# Descobrindo qual é a turma e curso de cada aluno
select tbl_aluno.id_aluno, tbl_aluno.nome, tbl_turma.id_turma,
tbl_turma.codigo_turma, tbl_curso.nome from tbl_aluno
inner join tbl_turma on tbl_turma.id_turma = tbl_aluno.id_turma
inner join tbl_curso on tbl_curso.id_curso = tbl_turma.id_curso;

# Verificando a lista e a turma a qual a lista pertence
select tbl_lista.id_lista, tbl_lista.data_lista, tbl_turma.codigo_turma, tbl_curso.nome from tbl_lista
inner join tbl_turma on tbl_turma.id_turma = tbl_lista.id_turma
inner join tbl_curso on tbl_curso.id_curso = tbl_turma.id_curso;

# Alimentando a lista que salva o status do aluno
insert into tbl_lista_aluno (id_aluno, id_lista, status_aluno) values
(1, 1, 'presente'), (2, 1, 'ausente'), (3, 1,'presente'),
(4, 2, 'ausente'), (5, 2, 'ausente'), (6, 2,'presente'),
(7, 3, 'presente'), (8, 3, 'ausente'), (9, 3,'presente'),
(10, 4, 'ausente'), (11, 4, 'presente'), (12, 4,'presente'),
(13, 5, 'presente'), (14, 5, 'presente'), (15, 5,'presente'),
(16, 6, 'presente'), (17, 6, 'presente'), (18, 6,'presente'),
(19, 7, 'presente'), (20, 7, 'ausente'), (21, 7,'presente'),
(22, 8, 'ausente'), (23, 8, 'ausente'), (24, 8,'presente');
select * from tbl_lista_aluno;

-- Consulta totalmente funcional.
select tbl_aluno.id_aluno, tbl_aluno.nome, tbl_lista_aluno.status_aluno, 
tbl_lista.data_lista, tbl_turma.codigo_turma, tbl_curso.nome, tbl_disciplina.nome from tbl_aluno
inner join tbl_lista_aluno on tbl_aluno.id_aluno = tbl_lista_aluno.id_aluno
inner join tbl_lista on tbl_lista.id_lista = tbl_lista_aluno.id_lista
inner join tbl_turma on tbl_turma.id_turma = tbl_lista.id_turma
inner join tbl_curso on tbl_curso.id_curso = tbl_turma.id_curso
inner join tbl_disciplina on tbl_disciplina.id_disciplina = tbl_lista.id_disciplina;

-- Cadastrando uma nota, sem, primeiramente atribuir a um aluno
select * from tbl_nota;
insert into tbl_nota (nota, tipo) values
('9.8', 'Trabalho em grupo'),
('9.2', 'Trabalho em grupo'),
('8.8', 'Trabalho em grupo'),
('7.0', 'Avaliação Final');

-- Atrelando a nota a uma disciplina
select tbl_disciplina.id_disciplina, tbl_disciplina.nome from tbl_disciplina;
insert into tbl_nota_disciplina (id_nota, id_disciplina) values
(1, 1), (2, 1), (3, 1), (4, 1);

-- Atrelando a nota, a um aluno em especifico
insert into tbl_aluno_nota (id_aluno, id_nota) values
(1, 1), (1, 2), (1, 3), (1, 4);
select * from tbl_aluno_nota;

# Checando as notas do aluno, por disciplina
select tbl_aluno.nome, tbl_disciplina.nome, tbl_nota.nota, tbl_nota.tipo from tbl_aluno
inner join tbl_aluno_nota on tbl_aluno.id_aluno = tbl_aluno_nota.id_aluno
inner join tbl_nota on tbl_nota.id_nota = tbl_aluno_nota.id_nota
inner join tbl_nota_disciplina on tbl_nota.id_nota = tbl_nota_disciplina.id_nota
inner join tbl_disciplina on tbl_disciplina.id_disciplina = tbl_nota_disciplina.id_disciplina;

