-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 19-Abr-2021 às 01:21
-- Versão do servidor: 5.7.26
-- versão do PHP: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gestao_tcc`
--
CREATE DATABASE IF NOT EXISTS `gestao_tcc` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gestao_tcc`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id_com` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_task` int(11) NOT NULL,
  `date_com` date NOT NULL,
  PRIMARY KEY (`id_com`),
  KEY `fk_user_com` (`id_user`),
  KEY `fk_task_com` (`id_task`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE IF NOT EXISTS `project` (
  `id_proj` int(11) NOT NULL AUTO_INCREMENT,
  `name_proj` varchar(50) NOT NULL,
  `prof_id` int(11) NOT NULL,
  `doc_link` varchar(255) DEFAULT NULL,
  `git_link` varchar(255) DEFAULT NULL,
  `initial_date` date NOT NULL,
  `final_date` date DEFAULT NULL,
  `desc_proj` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_proj`),
  KEY `prof_id` (`prof_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `project`
--

INSERT INTO `project` (`id_proj`, `name_proj`, `prof_id`, `doc_link`, `git_link`, `initial_date`, `final_date`, `desc_proj`) VALUES
(1, 'Projeto teste', 1, NULL, NULL, '2020-08-22', NULL, 'Projeto exemplo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id_task` int(11) NOT NULL AUTO_INCREMENT,
  `name_task` varchar(100) NOT NULL,
  `initial_date_task` date NOT NULL,
  `final_date_task` date DEFAULT NULL,
  `status_task` varchar(50) NOT NULL,
  `desc_task` varchar(255) DEFAULT NULL,
  `type_task` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_task`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tasks`
--

INSERT INTO `tasks` (`id_task`, `name_task`, `initial_date_task`, `final_date_task`, `status_task`, `desc_task`, `type_task`) VALUES
(1, 'Task 1', '2020-08-22', NULL, 'Em Andamento', 'Tarefa teste', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(255) NOT NULL AUTO_INCREMENT,
  `name_user` varchar(50) NOT NULL,
  `email_user` varchar(100) NOT NULL,
  `is_adm` tinyint(1) NOT NULL,
  `pass_user` varchar(50) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `user`
--

INSERT INTO `user` (`id_user`, `name_user`, `email_user`, `is_adm`, `pass_user`) VALUES
(1, 'admin', 'admin@admin.com', 1, 'admin'),
(2, 'aluno1', 'aluno1@aluno.ocm', 0, 'aluno1'),
(3, 'aluno2', 'aluno2@aluno.com', 0, 'aluno2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_proj`
--

DROP TABLE IF EXISTS `user_proj`;
CREATE TABLE IF NOT EXISTS `user_proj` (
  `id_up` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_up` int(11) NOT NULL,
  `id_proj_up` int(11) NOT NULL,
  PRIMARY KEY (`id_up`),
  KEY `id_user_up` (`id_user_up`),
  KEY `id_proj_up` (`id_proj_up`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `user_proj`
--

INSERT INTO `user_proj` (`id_up`, `id_user_up`, `id_proj_up`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 2, 1),
(4, 3, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_task`
--

DROP TABLE IF EXISTS `user_task`;
CREATE TABLE IF NOT EXISTS `user_task` (
  `id_user_task` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_ut` int(11) NOT NULL,
  `id_task_ut` int(11) NOT NULL,
  PRIMARY KEY (`id_user_task`),
  KEY `fk_user_ut` (`id_user_ut`),
  KEY `fs_task_ut` (`id_task_ut`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `user_task`
--

INSERT INTO `user_task` (`id_user_task`, `id_user_ut`, `id_task_ut`) VALUES
(1, 2, 1),
(2, 3, 1),
(3, 2, 1),
(4, 3, 1);

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_task_com` FOREIGN KEY (`id_task`) REFERENCES `tasks` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_com` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `fk_project_profesor` FOREIGN KEY (`prof_id`) REFERENCES `user` (`id_user`);

--
-- Limitadores para a tabela `user_proj`
--
ALTER TABLE `user_proj`
  ADD CONSTRAINT `fk_proj_up` FOREIGN KEY (`id_proj_up`) REFERENCES `project` (`id_proj`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_up` FOREIGN KEY (`id_user_up`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `user_task`
--
ALTER TABLE `user_task`
  ADD CONSTRAINT `fk_user_ut` FOREIGN KEY (`id_user_ut`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fs_task_ut` FOREIGN KEY (`id_task_ut`) REFERENCES `tasks` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Database: `localfarmdb`
--
CREATE DATABASE IF NOT EXISTS `localfarmdb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `localfarmdb`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `producao`
--

DROP TABLE IF EXISTS `producao`;
CREATE TABLE IF NOT EXISTS `producao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) NOT NULL,
  `qtd` int(10) NOT NULL,
  `preco_uni` float NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `data_prod` date NOT NULL,
  `id_usu` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usu` (`id_usu`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `producao`
--

INSERT INTO `producao` (`id`, `tipo`, `qtd`, `preco_uni`, `descricao`, `data_prod`, `id_usu`) VALUES
(1, 'banana', 68, 5.19, 'A banana é uma fruta rica em fibras, potássio, vitaminas C e A, promove energia e possui muitos benefícios ao nosso organismo.', '2019-03-18', 1),
(2, 'batata', 88, 2.37, ' batata inglesa, quando preparada corretamente, pode trazer benefícios à saúde.', '2019-07-28', 3),
(3, 'pera', 125, 3.78, 'Os benefícios da pera incluem uma grande quantidade de vitaminas, antioxidantes, fibras, proteínas, além de muita água.', '2019-06-15', 5),
(4, 'beterraba', 81, 2.85, 'A beterraba traz benefícios para a saúde como prevenir câncer, diminuir a pressão alta, prevenir catarata e fortalecer o sistema imune.', '2019-04-01', 4),
(5, 'cenoura', 51, 6.81, 'A cenoura é uma raiz que traz benefícios para a saúde como prevenir o envelhecimento, câncer, proteger a visão e manter o bronzeado.', '2019-02-20', 1),
(6, 'uva', 57, 4.16, 'A uva é fonte de carboidratos, importantes para o fornecimento de energia para o corpo. Também contém vitamina C, vitaminas do complexo B e sais minerais como ferro, cálcio e potássio.', '2019-01-19', 2),
(7, 'tomate', 88, 3.75, 'Além de muito rico em nutrientes, o fruto também tem diversos benefícios como manter a pele saudável.', '2019-04-16', 5),
(8, 'pera', 77, 2.96, 'Os benefícios da pera incluem uma grande quantidade de vitaminas, antioxidantes, fibras, proteínas, além de muita água.', '2019-05-15', 1),
(9, 'pêssego', 60, 7.89, 'O pêssego é uma fruta típica do verão abundante em nutrientes como vitaminas A, C e do complexo B, além de conter uma casca comestível rica em fibras que ajudam no funcionamento do intestino e dão saciedade', '2019-04-11', 5),
(10, 'pêssego', 121, 4.5, 'O pêssego é uma fruta típica do verão abundante em nutrientes como vitaminas A, C e do complexo B, além de conter uma casca comestível rica em fibras que ajudam no funcionamento do intestino e dão saciedade', '2019-01-13', 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `prod_vend`
--

DROP TABLE IF EXISTS `prod_vend`;
CREATE TABLE IF NOT EXISTS `prod_vend` (
  `id_prod_vend` int(10) NOT NULL AUTO_INCREMENT,
  `qtd` int(10) NOT NULL,
  `id_venda` int(10) NOT NULL,
  `id_prod` int(10) NOT NULL,
  PRIMARY KEY (`id_prod_vend`),
  KEY `fk_to_vend` (`id_venda`),
  KEY `fk_to_prod` (`id_prod`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `prod_vend`
--

INSERT INTO `prod_vend` (`id_prod_vend`, `qtd`, `id_venda`, `id_prod`) VALUES
(1, 62, 4, 12),
(2, 66, 5, 5),
(3, 78, 1, 4),
(4, 84, 9, 5),
(5, 105, 4, 8),
(6, 70, 1, 11),
(7, 63, 4, 3),
(8, 80, 7, 2),
(9, 51, 2, 7),
(10, 50, 7, 3),
(11, 56, 7, 14),
(12, 50, 8, 5),
(13, 77, 3, 1),
(14, 65, 10, 10),
(15, 63, 5, 14),
(16, 53, 1, 6),
(17, 53, 4, 8),
(18, 54, 9, 11),
(19, 92, 3, 13),
(20, 70, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `cpf` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `end` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`id`, `nome`, `cpf`, `email`, `senha`, `end`) VALUES
(1, 'Renato Aquino', '47052267801', 'renato@gmail.com', 'admin', 'rua Durvalino , 176'),
(2, 'Gugu Liberato', '852654495125', 'gugu@sdds.com', 'guguLiberato', 'ceu'),
(3, 'Michael Jackson', '75395148625', 'michael@naomorreu.com', 'tovivo', 'bahia, 666 - proxima a casa do elvis\r\n'),
(4, 'Ana Maria Braga', '36974162458', 'anaMB@gmail.com', 'loroJose@123', 'porjac rio'),
(5, 'Pele', '12398758564', 'reipele@yahoo.com', 'santos@1000gols', 'sla kkk\r\n');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendas`
--

DROP TABLE IF EXISTS `vendas`;
CREATE TABLE IF NOT EXISTS `vendas` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `vendas`
--

INSERT INTO `vendas` (`id`, `data`) VALUES
(1, '2019-03-18'),
(2, '2019-07-28'),
(3, '2019-06-15'),
(4, '2019-04-01'),
(5, '2019-02-20'),
(6, '2019-01-19'),
(7, '2019-04-16'),
(8, '2019-05-15'),
(9, '2019-04-11'),
(10, '2019-01-13');
--
-- Database: `sgtcc2`
--
CREATE DATABASE IF NOT EXISTS `sgtcc2` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sgtcc2`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id_com` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_task` int(11) NOT NULL,
  `date_com` date NOT NULL,
  PRIMARY KEY (`id_com`),
  KEY `fk_user_com` (`id_user`),
  KEY `fk_task_com` (`id_task`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `comment`
--

INSERT INTO `comment` (`id_com`, `content`, `id_user`, `id_task`, `date_com`) VALUES
(1, 'Este e o comentario numero 1', 2, 1, '2020-08-22'),
(2, 'Bom trabalho turma!', 2, 4, '2020-09-29'),
(3, 'Se fosse com laranjas eu saberia!', 3, 5, '2020-09-14'),
(4, 'Boa Sorte!', 3, 5, '2020-09-14'),
(5, 'Aeeee!', 2, 3, '2020-09-19');

-- --------------------------------------------------------

--
-- Estrutura da tabela `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE IF NOT EXISTS `project` (
  `id_proj` int(11) NOT NULL AUTO_INCREMENT,
  `name_proj` varchar(50) NOT NULL,
  `prof_id` int(11) NOT NULL,
  `doc_link` varchar(255) DEFAULT NULL,
  `git_link` varchar(255) DEFAULT NULL,
  `initial_date` date NOT NULL,
  `final_date` date DEFAULT NULL,
  `desc_proj` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_proj`),
  KEY `prof_id` (`prof_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `project`
--

INSERT INTO `project` (`id_proj`, `name_proj`, `prof_id`, `doc_link`, `git_link`, `initial_date`, `final_date`, `desc_proj`) VALUES
(1, 'Projeto teste', 1, NULL, NULL, '2020-08-22', NULL, 'Projeto exemplo'),
(2, 'Projeto2', 1, 'https://drive.google.com', 'https://github.com', '2020-08-24', '2020-08-29', 'Projeto de Exemplo numero 2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `proj_task`
--

DROP TABLE IF EXISTS `proj_task`;
CREATE TABLE IF NOT EXISTS `proj_task` (
  `id_proj_task` int(11) NOT NULL AUTO_INCREMENT,
  `id_proj_pt` int(11) NOT NULL,
  `id_task_pt` int(11) NOT NULL,
  PRIMARY KEY (`id_proj_task`),
  KEY `fk_proj_pt` (`id_proj_pt`),
  KEY `fs_task_pt` (`id_task_pt`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `proj_task`
--

INSERT INTO `proj_task` (`id_proj_task`, `id_proj_pt`, `id_task_pt`) VALUES
(1, 2, 1),
(2, 2, 3),
(3, 2, 4),
(4, 2, 5),
(5, 2, 6),
(6, 2, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `task`
--

DROP TABLE IF EXISTS `task`;
CREATE TABLE IF NOT EXISTS `task` (
  `id_task` int(11) NOT NULL AUTO_INCREMENT,
  `name_task` varchar(100) NOT NULL,
  `initial_date_task` date NOT NULL,
  `final_date_task` date DEFAULT NULL,
  `duration_task` varchar(50) NOT NULL,
  `status_task` varchar(50) NOT NULL,
  `desc_task` varchar(255) DEFAULT NULL,
  `type_task` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_task`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `task`
--

INSERT INTO `task` (`id_task`, `name_task`, `initial_date_task`, `final_date_task`, `duration_task`, `status_task`, `desc_task`, `type_task`) VALUES
(1, 'Task 1', '2020-08-22', NULL, '', 'Em Andamento', 'Tarefa teste', NULL),
(2, 'Task2', '2020-08-22', '2020-08-29', '', 'Em Andamento', 'Tarefa teste2', 'prototipagem'),
(3, 'Layout', '2020-08-25', '2020-08-30', '16 Horas', 'Aprovado', 'Desenhar o layout do site', 'Design'),
(4, 'Formulario', '2020-08-26', '2020-09-02', '4 Horas', 'Aprovado', 'Formulario Login', 'Design'),
(5, 'Backend Login', '2020-08-16', '2020-09-09', '40 Horas', 'Concluido', 'Fazer o backend da pagina de login', 'Desenvolvimento'),
(6, 'Backend Home', '2020-08-10', '2020-09-01', '30 Horas', 'Em Andamento', 'Fazer o backend da Home', 'Desenvolvimento'),
(7, 'Redigir Introducao', '2020-05-10', '2020-10-20', '18 Horas', 'Em Andamento', 'Fazer a Introducao do TCC', 'Escrita'),
(8, 'Redigir Metodologia', '2020-05-05', '2020-10-15', '25 Horas', 'Para Fazer', 'Fazer a metodologia  do TCC', 'Escrita'),
(9, 'Levantamento Bibliografico', '2020-05-05', '2020-10-15', '25 Horas', 'Revisar', 'Levantamento Bibliografico  do TCC', 'Escrita'),
(10, 'Backend Home', '2020-08-10', '2020-09-01', '30 Horas', 'Em Andamento', 'Fazer o backend da Home', 'Desenvolvimento'),
(11, 'Backend Logout', '2020-08-29', '2020-09-01', '5 Horas', 'Revisar', 'Fazer o backend Logout', 'Desenvolvimento');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(255) NOT NULL AUTO_INCREMENT,
  `name_user` varchar(50) NOT NULL,
  `email_user` varchar(100) NOT NULL,
  `is_adm` tinyint(1) NOT NULL,
  `pass_user` varchar(50) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `user`
--

INSERT INTO `user` (`id_user`, `name_user`, `email_user`, `is_adm`, `pass_user`) VALUES
(1, 'admin', 'admin@admin.com', 1, 'admin'),
(2, 'aluno1', 'aluno1@aluno.com', 0, 'aluno1'),
(3, 'aluno2', 'aluno2@aluno.com', 0, 'aluno2'),
(4, 'aluno3', 'aluno3@aluno.com', 1, 'aluno3'),
(5, 'Professor2', 'prof2@prof.com', 1, 'senhaprof'),
(7, 'Aluno', 'aluno3@aluno.com', 0, '123');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_proj`
--

DROP TABLE IF EXISTS `user_proj`;
CREATE TABLE IF NOT EXISTS `user_proj` (
  `id_up` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_up` int(11) NOT NULL,
  `id_proj_up` int(11) NOT NULL,
  PRIMARY KEY (`id_up`),
  KEY `id_user_up` (`id_user_up`),
  KEY `id_proj_up` (`id_proj_up`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `user_proj`
--

INSERT INTO `user_proj` (`id_up`, `id_user_up`, `id_proj_up`) VALUES
(1, 2, 2),
(2, 3, 1),
(3, 2, 1),
(4, 4, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_task`
--

DROP TABLE IF EXISTS `user_task`;
CREATE TABLE IF NOT EXISTS `user_task` (
  `id_user_task` int(11) NOT NULL AUTO_INCREMENT,
  `id_user_ut` int(11) NOT NULL,
  `id_task_ut` int(11) NOT NULL,
  PRIMARY KEY (`id_user_task`),
  KEY `fk_user_ut` (`id_user_ut`),
  KEY `fs_task_ut` (`id_task_ut`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `user_task`
--

INSERT INTO `user_task` (`id_user_task`, `id_user_ut`, `id_task_ut`) VALUES
(1, 2, 4),
(2, 3, 7),
(3, 2, 5),
(4, 4, 10);

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `fk_task_com` FOREIGN KEY (`id_task`) REFERENCES `task` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_com` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `fk_project_profesor` FOREIGN KEY (`prof_id`) REFERENCES `user` (`id_user`);

--
-- Limitadores para a tabela `user_proj`
--
ALTER TABLE `user_proj`
  ADD CONSTRAINT `fk_proj_up` FOREIGN KEY (`id_proj_up`) REFERENCES `project` (`id_proj`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_up` FOREIGN KEY (`id_user_up`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `user_task`
--
ALTER TABLE `user_task`
  ADD CONSTRAINT `fk_user_ut` FOREIGN KEY (`id_user_ut`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fs_task_ut` FOREIGN KEY (`id_task_ut`) REFERENCES `task` (`id_task`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Database: `skr`
--
CREATE DATABASE IF NOT EXISTS `skr` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `skr`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `buildings`
--

DROP TABLE IF EXISTS `buildings`;
CREATE TABLE IF NOT EXISTS `buildings` (
  `idBuilding` int(20) NOT NULL AUTO_INCREMENT,
  `titleBuilding` varchar(50) NOT NULL,
  `typeBuilding` varchar(50) NOT NULL,
  `descBuilding` longtext NOT NULL,
  `categoryBuilding` varchar(50) NOT NULL,
  `LATbuilding` varchar(50) NOT NULL,
  `LONGbuilding` varchar(50) NOT NULL,
  PRIMARY KEY (`idBuilding`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `buildings`
--

INSERT INTO `buildings` (`idBuilding`, `titleBuilding`, `typeBuilding`, `descBuilding`, `categoryBuilding`, `LATbuilding`, `LONGbuilding`) VALUES
(1, 'Panorama', 'residential', 'Um novo olhar para a sofisticação. Em um dos pontos mais nobres da Vila Romana, a SKR apresenta um projeto que traz para o bairro um novo e sofisticado olhar. Arquitetura contemporânea, poucas unidades, hall privativo em todos os apartamentos e uma varanda com vista de tirar o fôlego. As áreas de lazer, como quadra de tênis e praça gourmet, foram pensadas para dar um toque a mais de exclusividade.', 'realise', '-23.52864695043207', '-46.700954396119975'),
(2, 'Momento', 'residential', 'O MOMENTO Mota Pais é uma pausa, um espaço, um silêncio no seu dia a dia. O projeto de Hector Vigliecca privilegia os grandes ambientes, as frestas, a brisa, a luz e a vista da copa das árvores para você passar mais tempo em casa. MOMENTO é a opção para viver tranquilo, sem o vaivém frenético de São Paulo na porta de casa, mas do ladinho do que a cidade tem de melhor. É o lugar certo para você dedicar mais tempo ao que realmente importa, a família. Áreas comuns entregues decoradas e equipadas conforme memorial descritivo. Móveis, equipamentos, objetos de decoração, louças, metais e revestimentos de piso e parede sujeitos a alteração. Projeto executivo em desenvolvimento, podendo sofrer pequenas alterações durante as compatibilizações técnicas.', 'realise', '-23.536919507452083', '-46.70519868220859'),
(3, 'Float', 'residential', 'Um projeto meticulosamente pensado para ser um marco na cidade de São Paulo. Tudo no FLOAT by Yoo reflete a filosofia da parceria que construímos. Os detalhes do desenho de linhas contemporâneas com requintes modernistas trazido por Angelo Bucci. A solidez e compromisso da SKR em fazer projetos de arquitetura emblemática e que inspirem novas experiências de viver. FLOAT by Yoo é composto por uma torre única e espetacular. Os apartamentos não se tocam e são banhados o dia todo pelo sol. A fachada marcante traz para a Vila Olímpia um projeto cosmopolita que poderia estar nas metrópoles mais interessantes do mundo. ', 'realise', '-23.593724765568773', '-46.68274453442711'),
(4, 'Moou', 'residential', 'A Vila Madalena é o lugar de quem acredita que viver também é se inspirar, criar, conviver e interagir. Um empreendimento pensado para jovens de todas as gerações, para os sonhadores, os criativos, os descolados, aqueles que se inspiram com a arte e o design, com a natureza, a tecnologia e a conectividade.', 'conclude', '-23.55581925840702', '-46.692648685456916'),
(5, 'Escritório Vergueiro', 'commercial', 'Uma região mais que consolidada, com potencial e oportunidades crescentes. O projeto arquitetônico valoriza seu investimento e seu conforto a partir da entrada. Linhas arrojadas sobre todos os ângulos. Inspirado na vida moderna, Escritórios  Vergueiro evidencia tudo aquilo que o seu  dia a dia necessita: mobilidade e interatividade aliadas a áreas comuns funcionais e a uma concepção arquitetônica irretocável. Mais que um projeto imobiliário, é um novo  jeito de projetar sua vida profissional. Entre o paraíso, a paulista e o centro. Proximidade total com seus clientes e os melhores negócios.', 'conclude', '-23.563171191118276', '-46.63794393068151'),
(6, 'Green Design Office', 'commercial', 'Green Design Office Santana inova ao unir arquitetura e área verde em um mesmo local para garantir total bem-estar no horário comercial. Um projeto diferenciado, com integração total entre o verde e o ambiente de trabalho. ', 'conclude', '-23.50346103993176', '-46.64243333579712'),
(7, 'Escritório Paulista Jardim ', 'commercial', 'Localização estratégica para o seu negócio. Ao lado de um endereço que é referência mundial, a Avenida Paulista. Centro comercial e financeiro da América Latina, a região conta com a maior e melhor infraestrutura de comércio e serviços. Espaços bem pensados e planejados como você sempre imaginou.', 'conclude', '-23.57310063495898', '-46.64522217380834'),
(8, 'Escritório Europa', 'commercial', 'O projeto Escritórios Europa tem como base, edifícios de escritórios já existentes, porém completamente remodelados para as novas exigências do mercado. Situado no bairro do Itaim Bibi, na valorizada Avenida Nove de Julho, localização central da cidade, que oferece completa estrutura de comércio, serviços e lazer.', 'conclude', '-23.57761577085218', '-46.6730756822088'),
(9, 'Nomad', 'residential', 'Um dia o conceito de morar não vai mais ser o mesmo. As pessoas vão entender que vive melhor quem vive de forma colaborativa. É por isso que vão existir menos muros e mais janelas. Um dia, as pessoas terão suas casas na palma da mão. Esse dia, que alguns chamam de amanhã, chegou.', 'conclude', '-23.60776316936206', '-46.66351100760784'),
(10, 'Tom 1102', 'residential', 'Uma torre e apenas 19 apartamentos.Único para morar. Apartamentos com o tamanho ideal para receber e perfeitos para o conforto do dia a dia. Facilidades sofisticadas como em um hotel boutique e uma série de características que tornam esse empreendimento único e exclusivo. Áreas de convivência que integram.', 'conclude', '-23.62188010139379', '-46.67477931534076'),
(11, 'Campo Belo', 'residential', 'Localização privilegiada, projeto exclusivo e transformador. Arquitetura Viva trás uma nova experiência do novo viver, com design único e inovador. Apartamentos de 157m²  e studios de 27m². Arquitetura assinada por LE Arquitetos. BREVE LANÇAMENTO.', 'realise', '-23.61718194100657', '-46.673048364418214'),
(12, 'Vila Clementino', 'residential', 'Único em todos os detalhes. Um modo diferente de viver. Com localização previlegiada na Vila Clementino. Lançamento previsto para 2021. ', 'realise', '-23.59913439737636', '-46.647693999999994'),
(13, 'Platinum', 'commercial', 'Edifício comercial de alto padrão na região da Avenida Paulista. Apenas dois conjuntos por andar. Moderno, seguro e de alto padrão. Projetado de acordo com as últimas tendências da arquitetura contemporânea, o Platinum traz um novo conceito em empreendimentos comerciais.', 'conclude', '-23.567653983035783', '-46.65166561737078'),
(14, 'Singo', 'residential', 'Tudo interage, conecta. Não é sobre morar, é sobre conectar. Seu estilo, história, atitudes, ideias e projeto de vida. Tudo no mesmo lugar. ', 'realise', '-23.53314128551738', '-46.67227701402928'),
(15, '55: Beacon', 'residential', 'Surpreendente. 55 : Beacon apresenta o mixed use: com escritórios, apartamentos residenciais de diferentes tipologias, terraços alternados e serviços de conveniência, no bairro mais cool de São Paulo. ', 'realise', '-23.54795246698815', '-46.68797203122971'),
(16, 'Artisan', 'residential', 'Arquitetura para toda a família. ARTISAN MOEMA nasceu da inquietação da SKR em inovar sempre.O projeto traz para Moema, região tradicional da cidade, uma nova visão do morar. É um projeto pensado para famílias modernas, alinhado com as principais tendências do mundo e que privilegia a sofisticação.Um empreendimento para quem valoriza os momentos em família, os itens de lazer que realmente importam, principalmente, para quem valoriza a arquitetura que cria uma sensação de exclusividade no apartamento.', 'realise', '-23.60189543761881', '-46.66504570239225'),
(17, 'Atmosfera', 'residential', 'Personalidade e estilo para várias gerações. Estilo sofisticado e arquitetura atemporal traduzem o edifício, permitindo sentir o aconchego das áreas comuns. Um empreendimento que o bem-estar sempre tem vez. ', 'conclude', '-23.604959579531894', '-46.61830478006707'),
(18, 'Artisan', 'residential', 'Único em todos os detalhes. Espaços singulares, ambientes delicados, endereço tradicional. Produto artesanal. Único. A arte da arquitetura de morar em seu estado puro. Na melhor rua do Campo Belo. Mais que um endereço, um posicionamento residencial. Expressão de elegância. Rua Edson, 110. A arte de viver se manifestando em nome e números. Contemplação do verde. Mobilidade urbana. Classe arquitetônica.', 'conclude', '-23.61826022876699', '-46.680326'),
(19, 'Blanc', 'residential', 'O empreendimento foi idealizado para receber seus melhores momentos. Inspirado na cor branca, além de trazer serenidade, amplitude e sofisticação, ele combina com tudo, feito para você se sentir à vontade. São 2 torres com 26 pavimentos tipo mais duplex. As duas unidades por andar reservam 4 dormitórios e todo o espaço que você e sua família merecem.', 'conclude', '-23.622735398925172', '-46.676759'),
(20, 'Unitt', 'residential', 'Todas as unidades do Unitt são duplex cujas plantas foram pensadas para assegurar plena racionalidade dos espaços.Três tipos de plantas. Seu apartamento do tamanho ideal, do seu jeito.', 'conclude', '-23.55916878528745', '-46.68297748220055'),
(21, 'Pascal', 'residential', 'O Pascal Campo Belo fica a 800 m do Aeroporto de Congonhas e a poucas quadras do acesso para o centro e para o litoral. Localizado entre as ruas Vieira de Moraes e Jesuíno Maciel, o Pascal está em um ponto alto de um bairro arborizado e tranquilo: uma localização que combina com a praticidade do próprio apartamento e, claro, com você.', 'conclude', '-23.625081680971597', '-46.665969802391785'),
(22, 'Domna', 'residential', 'Dominar o ambiente, conquistar o seu espaço, ser livre para materializar seus sonhos. Assim é viver em Domna. Domna é um estilo de morar, ter domínio sobre a própria liberdade. O visual de cores leves e linhas retas exprime a sua arquitura atual.', 'conclude', '-23.53404539311249', '-46.691739'),
(23, 'Attic', 'residential', 'Localizado nos Jardins, duas opções de planta e diversidade em lazer.  O conceito de viver bem é explorado a cada metro quadrado do Attic. Para quem busca mais do que um lugar para morar. Para quem quer espeço e não abre maos de exclusividade. Para quem vive o lado da vida. O lado Attic.', 'conclude', '-23.575225854149114', '-46.656185682209106'),
(24, 'Appia', 'residential', 'Amplos apartamentos, apenas uma unidade por andar. Oito opções de planta.', 'conclude', '-23.572772478875827', '-46.656866364418214'),
(25, 'Vivace', 'residential', 'Qualidade de vida, estilo e diversidade em opções de lazer. Um empreendimento que respira, cheio de espaço, inspirado em qualidade de vida. Arquitetura contemporânea da fachada, com linhas horizontais bem marcadas e terrraços com peitoril em vidro, traduz o desenvolvimento da Vila Romana.', 'conclude', '-23.52734139234117', '-46.69240640239359'),
(26, 'Jardin de Mermier', 'residential', 'Apartamentos de 113 m2 privativos. Localização com fácil acesso aos principais pontos da cidade. Tranqüilidade e praticidade.', 'conclude', '-23.61093971590187', '-46.63036507355562'),
(27, 'Doppio', 'residential', 'Um empreendimento com ampla área de lazer que valoriza os ambientes externos e internos.', 'conclude', '-23.529968056084872', '-46.72712263122984'),
(28, 'Fascino', 'residential', 'Linhas retas e elegantes de uma arquitetura contemporânea. Apartamentos de 380 m2; de área privativa muito bem distribuídos em amplos espaços.', 'conclude', '-23.566008014872697', '-46.66205794620721'),
(29, 'Sollo', 'residential', 'Uma linha arquitetônica moderna. Cores e texturas leves aliadas a traços retos e marcantes.', 'conclude', '-23.52715592926341', '-46.69621473123007'),
(30, 'Atrium', 'commercial', 'Conjuntos com 215m² de área privativa e localização em uma das regiões comerciais mais importantes de São Paulo. O edifício Atrium VII tem uma tipologia diferenciada que se baseia em uma grelha estrutural curva, um anteparo que gera sombra e conferie privacidade aos andares. As plantas em “L” permitem configurações simples e de alto aproveitamento da área de carpete.', 'conclude', '-23.59244019459533', '-46.68635316930865'),
(31, 'Positano', 'residential', 'Numa tranquila região de São Paulo, apartamentos de 386 m2 privativos com a segurança de apenas uma unidade por andar.', 'conclude', '-23.556869853290237', '-46.692802'),
(32, 'Miraflores', 'residential', 'Numa região calma e arborizada de São Paulo, apartamentos de 292 m2 de área privativa. Apenas uma unidade por andar.', 'conclude', '-23.57701745122104', '-46.688227338623996'),
(33, 'Itacuruçá', 'residential', 'Apartamentos duplex com 504 m2 privativos e apenas uma unidade por andar numa região de alto padrão.', 'conclude', '-23.562349380761095', '-46.669140338624'),
(34, 'Vista Verde', 'residential', 'Apartamentos de 298 m2 privativos sendo apenas uma unidade por andar. Localizado em uma das regiões mais privilegiadas de São Paulo.', 'conclude', '-23.565606460738675', '-46.665263661376'),
(35, 'Maracá', 'residential', 'Apartamentos de alto padrão com apenas uma unidade por andar e 260 m2; de área privativa.', 'conclude', '-23.549150878554897', '-46.66092458898654'),
(36, 'Boituva', 'residential', 'Tranquilidade e conforto em apartamentos de 212 m2 de área privativa em uma calma região da cidade.', 'conclude', '-23.53928593446584', '-46.669836'),
(37, 'Athena', 'residential', 'Numa das regiões mais nobres da metrópole, apartamentos de 233 m2 privativos. Apenas uma unidade por andar.', 'conclude', '-23.53411903861383', '-46.660407'),
(38, 'Daphne', 'residential', 'Com excelente localização, apartamentos de 196 m2 privativos e apenas uma unidade por andar.', 'conclude', '-23.55792527214384', '-46.667101'),
(39, 'Memphis', 'residential', 'Apartamentos de 218 m2 privativos e muito estilo numa das regiões mais nobres de São Paulo.', 'conclude', '-23.565456975849738', '-46.660697317791005'),
(40, 'Atlantis', 'commercial', 'Design arrojado e marcante. Apenas uma unidade por andar com 201 m2 de área privativa.', 'conclude', '-23.56163468162851', '-46.659534682209'),
(41, 'Genève', 'commercial', 'Edifício comercial com unidades de 141 m2 de área privativa.', 'conclude', '-23.58298147992723', '-46.68199568220901'),
(42, 'Cond. Nautilus', 'residential', 'Conjunto residencial de casas no litoral. O local ideal para descanso, lazer e reunião de amigos e familiares.', 'conclude', '-23.774182589898732', '-45.669791'),
(43, 'Lugano', 'commercial', 'Empreendimento comercial no Itaim com conjuntos de 101 m2 de área privativa.', 'conclude', '-23.581807814072594', '-46.679325'),
(44, 'L Ufficio', 'commercial', 'Edifício comercial com localização privilegiada na cidade de São Paulo.', 'conclude', '-23.5669131423462', '-46.657716224537005'),
(45, 'Antares', 'commercial', 'Empreendimento imponente localizado na região da Avenida Paulista. Conjuntos com 109 m2 de área privativa.', 'conclude', '-23.561752974636676', '-46.66016531779099'),
(46, 'Seculum', 'commercial', 'Conjuntos de 418 m2 de área privativa em impressionante edifício comercial na regiao da Faria Lima.', 'conclude', '-23.583967272794705', '-46.683904'),
(47, 'The Summit', 'residential', 'Ideal para a família, um empreendimento com a infraestrutura que você deseja.', 'conclude', '-23.56317959940881', '-46.680232682209'),
(48, 'Palazzo Merano', 'residential', 'Unidades com 447 m2. Apenas um por andar. Classe e estilo numa região privilegiada da cidade.', 'conclude', '-23.592518274797015', '-46.667462'),
(49, 'Palazzo Ducale', 'residential', 'Numa região privilegiada de São Paulo, apartamentos com 335 m2 de área privativa. Apenas um por andar.', 'conclude', '-23.569116232156002', '-46.66536883928602');

-- --------------------------------------------------------

--
-- Estrutura da tabela `images`
--

DROP TABLE IF EXISTS `images`;
CREATE TABLE IF NOT EXISTS `images` (
  `idImages` int(20) NOT NULL AUTO_INCREMENT,
  `idBuilding` int(20) NOT NULL,
  `urlImage` varchar(255) NOT NULL,
  PRIMARY KEY (`idImages`),
  KEY `fk_buildings_images` (`idBuilding`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `images`
--

INSERT INTO `images` (`idImages`, `idBuilding`, `urlImage`) VALUES
(1, 1, 'https://skr.com.br/public/uploads/0ed5ff0b35af295610bde99e7276781c.jpg'),
(2, 1, 'https://skr.com.br/public/uploads/8c9331fced3581677157c98d65cce318.jpg'),
(3, 2, 'https://skr.com.br/public/uploads/24a2fd0f4762eb03eb276504f6f87897.jpg'),
(4, 2, 'https://skr.com.br/public/uploads/e261d615c719263bf76d7ed4d278cc01.jpg'),
(5, 3, 'https://skr.com.br/public/uploads/6edbdc90dabbfabbb0e9399eba4765a8.jpg'),
(6, 3, 'https://skr.com.br/public/uploads/8304cd1ff9029991bb26b814f26e628a.jpg'),
(7, 4, 'https://skr.com.br/public/uploads/bb74b4713681824db28febd9eb3be2aa.jpg'),
(8, 4, 'https://skr.com.br/public/uploads/3eafc96dbf869cd90d221ac2836b305b.jpg'),
(9, 5, 'https://skr.com.br/public/uploads/8e882730ce10b7f7f5b04cfa646735a4.jpg'),
(10, 5, 'https://skr.com.br/public/uploads/f62a8d70dd0365062171344129f23621.jpg'),
(11, 6, 'https://skr.com.br/public/uploads/749ea202018e46bd46a3d7b8e53c4341.jpg'),
(12, 6, 'https://skr.com.br/public/uploads/f49f59d8d69ea270509a9b5162d24050.jpg'),
(13, 7, 'https://skr.com.br/public/uploads/bedb2fc327cc5940a97aea4f1b43dd6d.jpg'),
(14, 7, 'https://skr.com.br/public/uploads/27b91ba1c093a902bd3292fb83327418.jpg'),
(15, 8, 'https://skr.com.br/public/uploads/99ec0f3596f2c534b2b14f2960519778.jpg'),
(16, 8, 'https://skr.com.br/public/uploads/d1146ed84290cb8e22f30a012c3ee3a0.jp'),
(17, 9, 'https://skr.com.br/public/uploads/f810765044a1f091bc4ffa45c4ea26b8.jpg'),
(18, 9, 'https://skr.com.br/public/uploads/27ec62a20b33c86c15dc5221181ffea2.jpg'),
(19, 10, 'https://skr.com.br/public/uploads/83ddccf944df4d19b4b0bb1bebda5f3b.jpg'),
(20, 10, 'https://skr.com.br/public/uploads/64bfca5f50075b5eaca8792f1ea78374.jpg'),
(21, 11, 'https://skr.com.br/public/uploads/c123f6524c3d5cd957f51b8407249c2a.jpg'),
(22, 11, 'https://skr.com.br/public/uploads/03e8db8d0a0531bff95c52dd82a0c1e2.JPG'),
(23, 11, 'https://skr.com.br/public/uploads/2947b3a335b4c7c133f597e90942ca21.JPG'),
(24, 11, 'https://skr.com.br/public/uploads/aa0f27a11a4f6b406a101d611ba54c3f.JPG'),
(25, 12, 'https://skr.com.br/public/uploads/f21c1352280a7be8f2bad728f602f32d.jpg'),
(26, 12, 'https://skr.com.br/public/uploads/01a039819b0587f1bed406016ec97362.jpg'),
(27, 12, 'https://skr.com.br/public/uploads/da4d29f733f546a0ff60960891fa41ba.jpg'),
(28, 13, 'https://skr.com.br/public/uploads/8eb587849aeb4d29b2944ba32e98fe6a.jpg'),
(29, 13, 'https://skr.com.br/public/uploads/a5073b0974992111c0612066c32077ef.jpg'),
(30, 13, 'https://skr.com.br/public/uploads/cadef11cb9db818221a5bec0e4a29a3f.jpg'),
(31, 13, 'https://skr.com.br/public/uploads/16ff8b1218936c07d781c8032debad35.jpg'),
(32, 14, 'https://skr.com.br/public/uploads/7b2fce848daa7bcd83c9f9be6b33f117.jpg'),
(33, 14, 'https://skr.com.br/public/uploads/296ced256cd0125d3a41574ecd3c3518.jpg'),
(34, 14, 'https://skr.com.br/public/uploads/b25f049a9822ef58aeec7a6d4f28bfde.jpg'),
(35, 14, 'https://skr.com.br/public/uploads/f067deb6793e19ce622052cf74c98762.jpg'),
(36, 15, 'https://skr.com.br/public/uploads/d37214939b9ee57eea41315bb3c53ef7.jpg'),
(37, 15, 'https://skr.com.br/public/uploads/36e9a2fdb41130b5020c1c66980528f1.jpg'),
(38, 15, 'https://skr.com.br/public/uploads/1621acc7c01a0e7f6920fd08bd4f75fd.jpg'),
(39, 15, 'https://skr.com.br/public/uploads/a5e01bfae555f45985541bd5f4f785e5.jpg'),
(40, 16, 'https://skr.com.br/public/uploads/58cbbed6e534fc5c53248a1d4aa8c384.jpg'),
(41, 16, 'https://skr.com.br/public/uploads/f28f67c1cb51a3daabc55298f0341715.jpg'),
(42, 16, 'https://skr.com.br/public/uploads/f1a534f5dfc88521cf05107c4c9c578e.jpg'),
(43, 16, 'https://skr.com.br/public/uploads/49cab8a73aeb65d523789a326c958bcf.jpg'),
(44, 17, 'https://skr.com.br/public/uploads/65b255c796baf1e14713864d95eaeed0.jpg'),
(45, 17, 'https://skr.com.br/public/uploads/c39ebd1b7c6570070e4d7e25e0a1e6e9.jpg'),
(46, 18, 'https://skr.com.br/public/uploads/c642b21aa4fd0c3f321b22e445082880.jpg'),
(47, 18, 'https://skr.com.br/public/uploads/84a253fddbf51d0241043a8f310dbbf1.jpg'),
(48, 18, 'https://skr.com.br/public/uploads/b00fb5ce3c23ce93fabf372bfbaacaf2.jpg'),
(49, 18, 'https://skr.com.br/public/uploads/07e8cd2d75942770634c7a0684396ade.jpg'),
(50, 19, 'https://skr.com.br/public/uploads/89276194ad1ee556fe95289b7df18ccc.jpg'),
(51, 19, 'https://skr.com.br/public/uploads/aa97acee94482af7da3a1c4b5d14021f.jpg'),
(52, 20, 'https://skr.com.br/public/uploads/22b49b1c3b3af36160105fe332e25798.jpg'),
(53, 20, 'https://skr.com.br/public/uploads/7dac1de521d7ebfb0c90dd6ef1ed64cf.jpg'),
(54, 20, 'https://skr.com.br/public/uploads/78ca89555664e1b9ed2ad7013dc6149c.jpg'),
(55, 20, 'https://skr.com.br/public/uploads/592145ceeb706c7fa3b847e3160014dd.jpg'),
(56, 21, 'https://skr.com.br/public/uploads/28409b56e93a408ded855d9da6eba3f4.jpg'),
(57, 21, 'https://skr.com.br/public/uploads/4a6d5db4aec79e0b5570aab2761162eb.jpg'),
(58, 21, 'https://skr.com.br/public/uploads/abd065531057ce1fdf401d7fd06bb70a.jpg'),
(59, 21, 'https://skr.com.br/public/uploads/21029926e587321e89203ee470088172.jpg'),
(60, 22, 'https://skr.com.br/public/uploads/f727e749abd959135beaf75c1bac27c7.jpg'),
(61, 22, 'https://skr.com.br/public/uploads/179becb451a1eb77949740bbd3d8bfcd.jpg'),
(62, 25, 'https://skr.com.br/public/uploads/538d7efb88868fb8625d5da4bfdc1c5a.jpg'),
(63, 25, 'https://skr.com.br/public/uploads/cbfc86e877c6525d3b4febd1ed246995.jpg'),
(64, 24, 'https://skr.com.br/public/uploads/d228a98f057ebfcb27223434c94e9def.jpg'),
(65, 24, 'https://skr.com.br/public/uploads/59d91cb49dd7c0ecd15545ff68e43c16.jpg'),
(66, 24, 'https://skr.com.br/public/uploads/e4545b33cbf339ec17d372e3c34c0c59.jpg'),
(67, 24, 'https://skr.com.br/public/uploads/9bc283b929a4c45c7616b6555a30f94d.jpg'),
(68, 26, 'https://skr.com.br/public/uploads/68b6ada0074e3b3619e06a35f6393c85.jpg'),
(69, 26, 'https://skr.com.br/public/uploads/8fbb0aafe27db79f37273e3ac3ecc746.jpg'),
(70, 27, 'https://skr.com.br/public/uploads/fe9abfa175ee18feef008bb92c1d9869.jpg'),
(71, 27, 'https://skr.com.br/public/uploads/a353c3cf8d4fa702a7d14e601f63c952.jpg'),
(72, 28, 'https://skr.com.br/public/uploads/c5a74bda5bdfbb954c9306cdbe8a8807.jpg'),
(73, 28, 'https://skr.com.br/public/uploads/b68291506d3b127fb46d3c64540910b3.jpg'),
(74, 29, 'https://skr.com.br/public/uploads/f4e971c1a488e96bffb6715e5721ab37.jpg'),
(75, 29, 'https://skr.com.br/public/uploads/bb35751be2eea177e6b1440f3e59b95d.jpg'),
(76, 29, 'https://skr.com.br/public/uploads/3ff6c74cbc15de3a1980223c23bba23a.jpg'),
(77, 29, 'https://skr.com.br/public/uploads/08db36310111ff6e73ccdd4538bc3344.jpg'),
(78, 30, 'https://skr.com.br/public/uploads/984f9707d28215479b961cb8bb002cd4.jpg'),
(79, 30, 'https://skr.com.br/public/uploads/5326039161e6d4106898b2ba895b747e.jpg'),
(80, 30, 'https://skr.com.br/public/uploads/ba01053aa590d27a54dd9faea21417b0.jpg'),
(81, 30, 'https://skr.com.br/public/uploads/2f150d1cba4e479fd7f9af9c9c93bcc2.jpg'),
(82, 31, 'https://skr.com.br/public/uploads/a47ba2169a95c334f2c08d1e2adfbfa9.jpg'),
(83, 31, 'https://skr.com.br/public/uploads/604a05575ce9766b26a3a2fa4a1af68f.jpg'),
(84, 31, 'https://skr.com.br/public/uploads/932d77eef4cdc92bcf58e29711633a75.jpg'),
(85, 31, 'https://skr.com.br/public/uploads/2977e3e9f15dbe13db907f21efb29ab6.jpg'),
(86, 32, 'https://skr.com.br/public/uploads/ab832f2aa14889b6b306b4c213b6a03c.jpg'),
(87, 32, 'https://skr.com.br/public/uploads/9a42db7117bcb9e32bc3faf3bbcb1db5.jpg'),
(88, 33, 'https://skr.com.br/public/uploads/e182846b48072a6023f8aaa7c1012a73.jpg'),
(89, 33, 'https://skr.com.br/public/uploads/810fcab22186355e304d6da8592bf6a7.jpg'),
(90, 34, 'https://skr.com.br/public/uploads/beb41f08011db8be30c0c03189acab4c.jpg'),
(91, 34, 'https://skr.com.br/public/uploads/f08ce222439625893fe110ec8e01377e.jpg'),
(92, 35, 'https://skr.com.br/public/uploads/9f4eb77b1a66ec4f020950113ea16486.jpg'),
(93, 35, 'https://skr.com.br/public/uploads/e50931830fdb7b4bcc02311bbb071564.jpg'),
(94, 35, 'https://skr.com.br/public/uploads/2e213c6a5ffe966340abe1efd99ceb01.jpg'),
(95, 35, 'https://skr.com.br/public/uploads/6d9bfc5a7ef9f4cfa0f24e794eaf3267.jpg'),
(96, 36, 'https://skr.com.br/public/uploads/16e2c3aba7f7b8394daa88a570475dde.jpg'),
(97, 36, 'https://skr.com.br/public/uploads/91b881cf4546601c20e31ef7caddad12.jpg'),
(98, 37, 'https://skr.com.br/public/uploads/eac4f5ecb85571aa3590a3e84a854726.jpg'),
(99, 37, 'https://skr.com.br/public/uploads/49c02d67d12377cfdbaee65e390d704b.jpg'),
(100, 37, 'https://skr.com.br/public/uploads/0542f66010d6ce14ac5145856917a3b5.jpg'),
(101, 37, 'https://skr.com.br/public/uploads/7d4b123b8690ec0af38e30dd9e78acce.jpg'),
(102, 38, 'https://skr.com.br/public/uploads/d5d3acb53341b0621db02229c8430744.jpg'),
(103, 38, 'https://skr.com.br/public/uploads/b27a82eb99d898a08d89ac5e2aa5e026.jpg'),
(104, 39, 'https://skr.com.br/public/uploads/68250938d892872829f0649b05a9d33b.jpg'),
(105, 39, 'https://skr.com.br/public/uploads/7678fb9bae0d8f8fa4549a92ec83482b.jpg'),
(106, 40, 'https://skr.com.br/public/uploads/f94709253b62c95383d3710910a29f82.jpg'),
(107, 40, 'https://skr.com.br/public/uploads/cd94dafea0698c698cc2b29a3e61f34a.jpg'),
(108, 40, 'https://skr.com.br/public/uploads/054102d848b539c2ef36b53e16ef6edd.jpg'),
(109, 40, 'https://skr.com.br/public/uploads/1b157f2ca30f04e73be5be7cf2674bf6.jpg'),
(110, 41, 'https://skr.com.br/public/uploads/be11b74012a59e41c171da86f6ccc7c2.jpg'),
(111, 41, 'https://skr.com.br/public/uploads/cb24567e974ef34b8dd18bfe7a8db4d6.jpg'),
(112, 42, 'https://skr.com.br/public/uploads/defbbab57f0ee4acaae5974b841f9f03.jpg'),
(113, 42, 'https://skr.com.br/public/uploads/a7c09e28fbf3f81ed625b0ccbb663621.jpg'),
(114, 42, 'https://skr.com.br/public/uploads/af1a0a42e4927a9703d6293ab818744c.jpg'),
(115, 42, 'https://skr.com.br/public/uploads/e518e693816ceaee3c60cb7bc8b03fc9.jpg'),
(116, 43, 'https://skr.com.br/public/uploads/b3acd8aa642ef9589ca835cdc9272c4e.jpg'),
(117, 43, 'https://skr.com.br/public/uploads/f74b255aa60a014071f19032a3144d35.jpg'),
(118, 44, 'https://skr.com.br/public/uploads/a12e0332d4e8cf7818dc86cd345ce240.jpg'),
(119, 44, 'https://skr.com.br/public/uploads/d8082f26609b43ac1bf6a708817c182a.jpg'),
(120, 45, 'https://skr.com.br/public/uploads/db35c2f376861ea3ff8f574849780fdc.jpg'),
(121, 45, 'https://skr.com.br/public/uploads/a7cd70526f5ef53c8c96efa973b1a119.jpg'),
(122, 45, 'https://skr.com.br/public/uploads/b7b27ecefcf390c51fddc594b731857c.jpg'),
(123, 45, 'https://skr.com.br/public/uploads/b7b27ecefcf390c51fddc594b731857c.jpg'),
(124, 23, 'https://skr.com.br/public/uploads/83446ae1da4e124833914117bc88d4ab.jpg'),
(125, 23, 'https://skr.com.br/public/uploads/22bc3ef50f9866a1429d3d19c67067e5.jpg'),
(126, 46, 'https://skr.com.br/public/uploads/f0a2ffb931f62de7536c25d7df9bf30f.jpg'),
(127, 46, 'https://skr.com.br/public/uploads/0e4f9cf5ca9bf1ef5a9a3a0b1444abac.jpg'),
(128, 47, 'https://skr.com.br/public/uploads/977ebb09b7a555f2a835f5f804cfdcb3.jpg'),
(129, 47, 'https://skr.com.br/public/uploads/fe238cb94586ecb8a534b3aa507f2db7.jpg'),
(130, 47, 'https://skr.com.br/public/uploads/36021975133885faadfe1ab3d7d0ab56.jpg'),
(131, 48, 'https://skr.com.br/public/uploads/ce38f9c182b2b5ec63776cf682db5391.jpg'),
(132, 48, 'https://skr.com.br/public/uploads/9f14a0b25ef18261d226bdc1b6423d67.jpg'),
(133, 48, 'https://skr.com.br/public/uploads/275445866ae37aedaadb619fc53a66f9.jpg'),
(134, 49, 'https://skr.com.br/public/uploads/26366b7f43390b6470eea51b4c78b79e.jpg'),
(135, 49, 'https://skr.com.br/public/uploads/3b6578e16486f211efac89a42ac56daa.jpg'),
(136, 49, 'https://skr.com.br/public/uploads/6e51c8e6a644892b208386e53bdd4c73.jpg');

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `fk_buildings_images` FOREIGN KEY (`idBuilding`) REFERENCES `buildings` (`idBuilding`);
--
-- Database: `teste_api`
--
CREATE DATABASE IF NOT EXISTS `teste_api` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `teste_api`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `teste`
--

DROP TABLE IF EXISTS `teste`;
CREATE TABLE IF NOT EXISTS `teste` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `numero` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `teste`
--

INSERT INTO `teste` (`id`, `nome`, `numero`) VALUES
(1, 'Renato', 100),
(2, 'Tomaz', 200);
--
-- Database: `trabalho_lp2`
--
CREATE DATABASE IF NOT EXISTS `trabalho_lp2` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `trabalho_lp2`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) NOT NULL,
  `item_desc` varchar(255) NOT NULL,
  `item_img` varchar(255) NOT NULL,
  `item_status` varchar(20) NOT NULL,
  `user_id` int(255) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_item_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `item`
--

INSERT INTO `item` (`item_id`, `item_name`, `item_desc`, `item_img`, `item_status`, `user_id`) VALUES
(3, 'tenis', 'tenis zica ', 'img/01.jpg', 'Disponivel', 1),
(6, 'viola', 'So p quem toca modÃ£o', 'img/02.jpg', 'Disponivel', 1),
(7, 'Notebook', 'Meu pc', 'img/03.jpg', 'Disponivel', 2),
(8, 'Jatinho', 'Vai com piloto e gasolina', 'img/04.jpg', 'EMPRESTADO', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `loan`
--

DROP TABLE IF EXISTS `loan`;
CREATE TABLE IF NOT EXISTS `loan` (
  `id_loan` int(255) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `user_id` int(255) NOT NULL,
  `loan_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_loan`),
  KEY `fk_loan_user` (`user_id`),
  KEY `fk_loan_item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `loan`
--

INSERT INTO `loan` (`id_loan`, `item_id`, `user_id`, `loan_date`) VALUES
(26, 8, 1, '2020-10-05 01:21:51');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(255) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(200) NOT NULL,
  `user_email` varchar(200) NOT NULL,
  `user_pass` varchar(200) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_email`, `user_pass`) VALUES
(1, 'admin', 'email', 'admin'),
(2, 'renato', 'renato', 'renato');

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `fk_item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Limitadores para a tabela `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `fk_loan_item` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  ADD CONSTRAINT `fk_loan_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
