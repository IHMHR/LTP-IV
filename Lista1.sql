CREATE DATABASE LTP4;
GO

USE LTP4;
GO

CREATE SCHEMA DBPessoal;
GO

CREATE TABLE LTP4.DBPessoal.TabCargos (
cod_cargo INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
nome_cargo NVARCHAR(30) NOT NULL,
);

CREATE NONCLUSTERED INDEX idx_cargo ON DBPessoal.TabCargos(nome_cargo);

INSERT INTO DBPessoal.TabCargos
VALUES (N'Gerente Administrativo'),(N'Gerente de Informática'),(N'Gerente Comercial'),(N'Auxiliar Administrativo'),(N'Representante Comercial'),(N'Analista de Sistemas'),(N'Analista de Suporte'),(N'Analista B.Dados'),(N'Secretária'),(N'Gerente de Finanças');

CREATE TABLE LTP4.DBPessoal.TabDeptos (
cod_depto INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
nome_depto NVARCHAR(30) NOT NULL,
);

CREATE NONCLUSTERED INDEX idx_dpto ON DBPessoal.TabDeptos(nome_depto);

INSERT INTO DBPessoal.TabDeptos
VALUES (N'Administrativo'),(N'Comercial'),(N'Informática'),(N'Financeiro');

CREATE TABLE LTP4.DBPessoal.TabPessoal (
matricula INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
nome NVARCHAR(50) NOT NULL,
nascimento DATE NOT NULL,
cod_depto INT NOT NULL,
cod_cargo INT NOT NULL,
admissao DATE NOT NULL,
salario DECIMAL(9,2) NOT NULL,

FOREIGN KEY (cod_depto) REFERENCES DBPessoal.TabDeptos(cod_depto) ON DELETE NO ACTION,
FOREIGN KEY (cod_cargo) REFERENCES DBPessoal.TabCargos(cod_cargo) ON DELETE NO ACTION,
);

CREATE NONCLUSTERED INDEX idx_pessoal ON DBPessoal.TabPessoal(nascimento, admissao, salario);

INSERT INTO DBPessoal.TabPessoal 
VALUES (N'Eduardo Valadares','1982-01-05',1,1,'2000-01-02',12650.00),(N'Jose Augusto','1982-12-05',2,3,'2001-01-02',9075.00),(N'Claudia Gontijo Silva','1975-10-09',3,2,'2002-10-05',7260.00),(N'Ronaldo Morais','1972-10-08',1,4,'2002-02-05',968.00),(N'Katia Silva','1970-08-22',2,5,'2003-01-03',847.00),(N'Silvia Neto','1978-09-24',2,5,'2003-01-03',1089.00),(N'Carlos Xavier','1976-11-30',2,5,'2003-01-03',1210.00),
(N'Josefina Andrade','1981-01-20',3,6,'2002-01-10',4840.00),(N'Jose Silva Alves','1974-03-05',3,6,'2002-06-01',5445.00),(N'Cristina Andrade','1980-09-10',3,6,'2002-06-01',4235.00),(N'Claudia Neves','1980-09-15',3,6,'2000-10-15',2057.00),(N'Karla Chaves','1980-10-10',3,8,'2003-10-01',3630.00),(N'Julio Cesar','1978-09-15',1,4,'2002-09-10',2178.00),(N'Ana Paula Alves','1982-10-20',1,6,'2003-10-10',1210.00),
(N'Cristiano Dias','1980-10-10',1,4,'2003-11-05',1452.00),(N'Francisco Cunha','1980-10-10',1,4,'2004-04-26',2420.00),(N'Sebastiao Alves','1980-10-10',1,4,'2004-01-27',2420.00),(N'Francisco Dias','1980-01-01',1,4,'2004-05-18',2662.00),(N'Jose Dias','1979-05-12',2,5,'2004-05-19',1573.00),(N'Jose Carlos','1980-10-10',2,5,'2004-05-19',1452.00);

CREATE TABLE LTP4.DBPessoal.Tab_Desc_Dependencia (
cod_dependencia INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
desc_dependencia NVARCHAR(120) NOT NULL
);

CREATE NONCLUSTERED INDEX idx_dsc_dependencia ON DBPessoal.Tab_Desc_Dependencia(desc_dependencia);

INSERT INTO DBPessoal.Tab_Desc_Dependencia VALUES (N'A pessoa absolutamente incapaz, da qual o contribuiente seja tutor ou curador.'),(N'Companheiro(a) com o qual o contribuinte filho ou viva há mais de 5 anos ou cônjuge.'),
(N'Filho(a) ou enteado(a) até 21 anos, ou maior, se incapacitado física e/ou mentalmente para o trabalho.'),(N'Filho(a) ou enteado(a) até 24 anos, se universitário ou cursando escola técnica de 2º grau.'),
(N'Irmão, neto ou bisneto até 24 anos, cursando universidade ou escola téc. 2º grau, do qual detenha guarda judicial.'),(N'Irmão, neto ou bisneto sem arrimo até 21 anos ou incapaz física/mentalmente, do qual detenha a guarda judicial.'),
(N'Menor pobre até 21 anos que o contribuinte crie e eduque e do qual detenha guarda judicial.'),(N'Pais, avós e bisavós que em no ano receberam rendimentos, tributáveis ou não, até limite especificado pela receita.');

CREATE TABLE LTP4.DBPessoal.TabDependentes (
cod_dependente INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
matricula INT NOT NULL,
nome_dependente NVARCHAR(50) NOT NULL,
nascimento DATE NOT NULL,
cod_dependencia INT NOT NULL,

FOREIGN KEY (cod_dependencia) REFERENCES DBPessoal.Tab_Desc_Dependencia(cod_dependencia) ON DELETE NO ACTION
);

CREATE NONCLUSTERED INDEX idx_dependente ON DBPessoal.TabDependentes(nome_dependente,nascimento);

SET IDENTITY_INSERT LTP4.DBPessoal.TabDependentes ON;
INSERT INTO DBPessoal.TabDependentes (cod_dependente,matricula,nome_dependente,nascimento,cod_dependencia) VALUES (5,3,N'Sebastião Alves Siva','2003-10-10',3),(6,7,N'Ana Paula Xavier','2000-03-01',3),(8,17,N'Marcio Eduardo Alves','2001-09-12',3),(9,19,N'Isabel Almeida Dias','1988-03-25',2),(10,19,N'Joana Karla Dias','2001-01-12',3),(14,1,N'Eduardo Valadares Filho','2006-06-15',3),(15,1,N'Valeria Valadares','1985-03-01',2),(16,1,N'Jose Carlos Valadares','2003-09-10',3);
SET IDENTITY_INSERT LTP4.DBPessoal.TabDependentes OFF;

-- Verificando
SELECT * FROM DBPessoal.Tab_Desc_Dependencia;
SELECT * FROM DBPessoal.TabCargos;
SELECT * FROM DBPessoal.TabDependentes;
SELECT * FROM DBPessoal.TabDeptos;
SELECT * FROM DBPessoal.TabPessoal;

-- Lista 01
1) SELECT matricula, cod_depto, cod_cargo, nome, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', salario FROM DBPessoal.TabPessoal ORDER BY nome ASC, matricula ASC;
2) SELECT matricula, cod_depto, cod_cargo, nome, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', salario FROM DBPessoal.TabPessoal ORDER BY nome ASC, matricula DESC, admissao DESC, salario ASC;
3) SELECT matricula, nome, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', salario FROM DBPessoal.TabPessoal WHERE salario >= 1000 AND salario <= 2000 ORDER BY nome ASC;
4) SELECT matricula, cod_depto, cod_cargo, nome, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', salario FROM DBPessoal.TabPessoal WHERE nome LIKE N'%?%' ORDER BY nome ASC;
5) SELECT nome, d.nome_depto AS N'departamento', c.nome_cargo AS N'cargo' , CONVERT(VARCHAR, admissao, 103) AS N'Data de Admissão', salario FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabCargos c ON p.cod_cargo = c.cod_cargo INNER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto WHERE salario >= ? AND salario <= ? ORDER BY nome ASC;
6) SELECT nome_depto, nome, DAY(nascimento) AS 'Dia do Aniversário' FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto WHERE MONTH(nascimento) = MONTH(GETDATE()) ORDER BY nome_depto ASC, nome ASC;
7) SELECT nome, d.nome_depto AS N'departamento', c.nome_cargo AS N'cargo', DAY(admissao) AS N'Dia de Admissão' FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto INNER JOIN DBPessoal.TabCargos c ON p.cod_cargo = c.cod_cargo WHERE DATEDIFF(YEAR, admissao, GETDATE()) >= 1 AND MONTH(admissao) = MONTH(GETDATE()) AND nome_depto LIKE N'%?%' ORDER BY admissao ASC;
8) SELECT nome AS N'Nome do Empregado', p.matricula, nome_dependente AS N'Nome do Dependente', desc_dependencia AS N'Descrição da _Dependência' FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabDependentes d ON p.matricula = d.matricula INNER JOIN DBPessoal.Tab_Desc_Dependencia dd ON d.cod_dependencia = dd.cod_dependencia ORDER BY [Nome do Empregado] ASC;
9) SELECT nome, d.nome_depto AS N'departamento', CONVERT(VARCHAR, admissao, 103) AS 'Admissao', DATEDIFF(YEAR, admissao, GETDATE()) AS N'Tempo de Casa em Anos' FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto ORDER BY nome ASC, [Tempo de Casa em Anos] DESC;
10) SELECT nome_cargo AS N'Função', nome, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', salario FROM DBPessoal.TabPessoal p FULL OUTER JOIN DBPessoal.TabCargos c ON p.cod_cargo = c.cod_cargo ORDER BY [Função] ASC;
11) SELECT nome, p.matricula, dp.nome_depto AS N'departamento', salario, nome_dependente AS  N'Nome do Dependente', CONVERT(VARCHAR, d.nascimento, 103) AS 'Nascimento', desc_dependencia FROM DBPessoal.TabPessoal p FULL OUTER JOIN DBPessoal.TabDeptos dp ON p.cod_depto = dp.cod_depto LEFT JOIN DBPessoal.TabDependentes d ON p.matricula = d.matricula LEFT JOIN DBPessoal.Tab_Desc_Dependencia dd ON d.cod_dependente = dd.cod_dependencia WHERE nome IS NOT NULL ORDER BY nome ASC;
12) SELECT matricula, nome, CONVERT(VARCHAR, nascimento, 103) AS 'Nascimento', d.nome_depto AS N'departamento', c.nome_cargo AS N'cargo', salario, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', (SELECT COUNT(1) FROM DBPessoal.TabDependentes dd WHERE dd.matricula = p.matricula) AS 'Quantidade de Dependentes' FROM DBPessoal.TabPessoal p FULL OUTER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto FULL OUTER JOIN DBPessoal.TabCargos c ON p.cod_cargo = c.cod_cargo WHERE matricula > ? ORDER BY matricula OFFSET 0 ROW FETCH FIRST 1 ROW ONLY;
13) SELECT matricula, nome, d.nome_depto AS N'departamento', c.nome_cargo AS N'cargo', salario, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', (SELECT COUNT(1) FROM DBPessoal.TabDependentes dd WHERE dd.matricula = p.matricula) AS 'Quantidade de Dependentes' FROM DBPessoal.TabPessoal p FULL OUTER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto FULL OUTER JOIN DBPessoal.TabCargos c ON p.cod_cargo = c.cod_cargo WHERE matricula < ? ORDER BY matricula DESC OFFSET 0 ROW FETCH FIRST 1 ROW ONLY;
14) SELECT matricula, nome, CONVERT(VARCHAR, nascimento, 103) AS 'Nascimento', d.nome_depto AS N'departamento', c.nome_cargo AS N'cargo', salario, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', (SELECT COUNT(1) FROM DBPessoal.TabDependentes dd WHERE dd.matricula = p.matricula) AS 'Quantidade de Dependentes' FROM DBPessoal.TabPessoal p FULL OUTER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto INNER JOIN DBPessoal.TabCargos c ON p.cod_cargo = c.cod_cargo ORDER BY matricula ASC OFFSET 0 ROW FETCH FIRST 1 ROW ONLY;
15) SELECT TOP 1 matricula, nome, CONVERT(VARCHAR, nascimento, 103) AS 'Nascimento', d.nome_depto AS N'departamento', c.nome_cargo AS N'cargo', salario, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', (SELECT COUNT(1) FROM DBPessoal.TabDependentes dd WHERE dd.matricula = p.matricula) AS 'Quantidade de Dependentes' FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto FULL OUTER JOIN DBPessoal.TabCargos c ON p.cod_cargo = c.cod_cargo ORDER BY matricula DESC;
16) SELECT nome, nome_depto, CONVERT(VARCHAR, admissao, 103) AS 'Admissao', CONVERT(VARCHAR, nascimento, 103) AS 'Nascimento', salario FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabDeptos dp ON p.cod_depto = dp.cod_depto WHERE NOT EXISTS (SELECT 1 FROM DBPessoal.TabDependentes d WHERE d.matricula = p.matricula) ORDER BY nome ASC;
17) SELECT nome, matricula, N'1' AS 'Tipo', CONVERT(VARCHAR, nascimento, 103) AS 'Nascimento' FROM DBPessoal.TabPessoal UNION ALL SELECT nome_dependente, matricula, N'2' AS 'Tipo', CONVERT(VARCHAR, nascimento, 103) AS 'Nascimento' FROM DBPessoal.TabDependentes ORDER BY matricula ASC;
18) SELECT nome_depto, COUNT(matricula) AS 'Total Empregados', SUM(salario) AS 'Total Salários', CAST(AVG(salario) AS DECIMAL(9,2)) AS 'Salário Médio', MAX(salario) AS 'Maior Salário', MIN(salario) AS 'Menor Salário' FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabDeptos d ON p.cod_depto = d.cod_depto GROUP BY nome_depto HAVING SUM(salario) > ? AND SUM(salario) < ? ORDER BY nome_depto ASC;
19) SELECT nome_cargo, COUNT(matricula) AS 'Total Empregados', SUM(salario) AS 'Total Salários', CAST(AVG(salario) AS DECIMAL(9,2)) AS 'Salário Médio', MAX(salario) AS 'Maior Salário', MIN(salario) AS 'Menor Salário' FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabCargos c ON p.cod_cargo = c.cod_cargo WHERE nome_cargo LIKE N'%?%' GROUP BY nome_cargo HAVING AVG(salario) > ? AND AVG(salario) < ? ORDER BY nome_cargo ASC;
20) SELECT nome, salario, COUNT(d.cod_dependente) AS 'quantidade de dependentes' FROM DBPessoal.TabPessoal p INNER JOIN DBPessoal.TabDependentes d ON p.matricula = d.matricula GROUP BY nome, salario HAVING COUNT(d.cod_dependente) > ? AND COUNT(d.cod_dependente) < ? ORDER BY nome ASC;
21) INSERT INTO DBPessoal.TabCargos (nome_cargo) VALUES ('?');
22) INSERT INTO DBPessoal.TabPessoal (nome, nascimento, cod_depto, cod_cargo, admissao, salario) VALUES ('?','?',?,?,'?',?);
23) UPDATE DBPessoal.TabPessoal SET cod_cargo = ? WHERE matricula = ?;
24) UPDATE DBPessoal.TabPessoal SET cod_depto = ? WHERE matricula = ?;
25) UPDATE DBPessoal.TabPessoal SET salario = ? WHERE matricula = ?;
26) UPDATE DBPessoal.TabPessoal SET salario = ?;
27) DELETE FROM DBPessoal.TabPessoal WHERE matricula = ?;
