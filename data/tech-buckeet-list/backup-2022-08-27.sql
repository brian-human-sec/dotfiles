PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE tech_bucket_list (
  _id integer primary key autoincrement,
  description TEXT NOT NULL UNIQUE,
  difficulty INT,
  effort INT,
  priority INT,
  reoccurring INT,
  effort_type TEXT,
  complete datetime,
  last_updated datetime default current_timestamp,
  date_created datetime default current_timestamp
);
INSERT INTO tech_bucket_list VALUES(1,'setup ddwrt web frontend certificate',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(2,'port rapi-finance-endpoint to ktor',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(3,'port rapi-finance-endpoint to rust',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(4,'code submenu names in xmonad',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(5,'find a project to work on - fiverr.com - become a seller',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(6,'setup webserver for brianhenning.xyz',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(7,'build aes encrypt a file using haskell',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(8,'fix shell script to use new git pattern',NULL,NULL,NULL,NULL,'fix',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(9,'setup - virtualize pihole on docker proxmox',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(10,'build an android app',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(11,'setup - recording live tv on linux with silicondust hdhomerun',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(12,'learn to use obs for content creation',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(13,'learn squashing with git',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(14,'build an app to stream audio to an android phone',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(15,'update main windows 10 machine to the latest version',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(16,'linux - swap init program with bash (testing)',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(17,'setup - virtualize plexserver on docker in proxmox',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(18,'setup - virtualize nextcloud on docker in proxmox',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(19,'backup 2fa codes',NULL,NULL,NULL,NULL,'backup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(20,'backup photos',NULL,NULL,NULL,NULL,'backup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(21,'selfhost nextcloud (dropbox replacement)',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(22,'learn more about digital ocean',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(23,'learn more about aws',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(24,'learn more about azure',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(25,'learn more about goodle cloud service',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(26,'learn more about upcloud',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(27,'build - lora - setup a sender/receiver',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(28,'linux cross compiler for rasperrry pi arm',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(29,'gpg key on yubikey',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(30,'ssh key on yubikey',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(31,'setup linux pam module for yubikey',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(32,'build a spotify playlist extractor',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(33,'learn traefik (reverse proxy)',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(34,'build a python spotify app',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(35,'learn gimp basics - distrotube',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(36,'build a profile avitar',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(37,'finance app to output a budget',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(38,'JOOQ update and delete',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(39,'mine crypto currency',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(40,'build the automation for a bridge setup',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(41,'learn blender - make something 3D',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(42,'build a custom PCB',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(43,'build a FreeNAS server',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(44,'finance_db with redis backend',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(45,'finance_db with mongodb backend',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(46,'build a hardware hackintosh',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(47,'build a docker void server',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(48,'install haikuOS',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(49,'raspberian cross compiler in c on gentoo',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(50,'setup heroku dns with cloudflare',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(51,'build gentoo primary system',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(52,'dictation linux',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(53,'dictation macos',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(54,'fix ddwrt reverse proxy issue',NULL,NULL,NULL,NULL,'fix',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(55,'build a docker dns server',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(56,'setup bastion host on proxmox',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(57,'learn kali linux',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(58,'setup subdomain for fastly app',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(59,'learn kuberneties',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(60,'build custom kernel for gentoo',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(61,'backup configs for ddwrt, pihole, pfsense',NULL,NULL,NULL,1,'backup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(62,'migrate cert script to react and other apps',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(63,'setup fastly VCL',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(64,'learn replay attack for cookies',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(65,'setup nvim LSP',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(66,'build nvim LSP script for download',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(67,'learn express http router',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(68,'build portainer front end for docker',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(69,'build sqlite for contacts',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(70,'build sqlite for tech bucket list',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(71,'learn BOLA and IDOR',NULL,NULL,NULL,NULL,'learn',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(72,'setup proxmox certificate for webui',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(73,'fix pfsense certificate',NULL,NULL,NULL,NULL,'fix',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(74,'setup splunk in proxmox debian docker',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(75,'install nix packages to replace flatpak',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(76,'setup openwrt test network',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(77,'setup console fonts',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(78,'setup origin upstream from fastly',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(79,'setup linux color scheme everforest',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(80,'build lua nvim config',NULL,NULL,NULL,NULL,'build',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(81,'setup https certificate on the pihole',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(82,'fix xmonad warnings',NULL,NULL,NULL,NULL,'fix',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(83,'setup redis server on docker',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(84,'setup macvlan on docker',NULL,NULL,NULL,NULL,'setup',NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(85,'replace sudo with doas',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 16:08:33','2022-08-27 16:08:33');
INSERT INTO tech_bucket_list VALUES(86,'virtualize pihole on docker proxmox',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(87,'code an android app',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(88,'record live tv on linux with silicondust hdhomerun',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(89,'practice squashing with git',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(90,'virtualize plexserver on docker in proxmox',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(91,'virtualize nextcloud on docker in proxmox',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(92,'lora - setup a sender/receiver',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(93,'spotify playlist extract',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(94,'python spotify',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(95,'lean gimp basics - distrotube',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(96,'create profile avitar',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(97,'automate bridge setup',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(98,'make my own PCB',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(99,'install FreeNAS',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(100,'build hardware hackintosh',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(101,'docker run void',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(102,'gentoo primary system',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(103,'docker dns server on debian',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(104,'setup bastion host',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(105,'subdomain for fastly app',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(106,'gentoo setup and build custom kernel',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(107,'monthly backup ddwrt, pihole, pfsense',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(108,'install portainer front end for docker',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(109,'setup proxmox certificate',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(110,'nix packages to replace flatpak',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(111,'update lua nvim config',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(112,'setup https on the pihole',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(113,'setup docker redis server',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(114,'setup macvlan docker',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:13:55','2022-08-27 22:13:55');
INSERT INTO tech_bucket_list VALUES(115,'install bottles gentoo',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:15:52','2022-08-27 22:15:52');
INSERT INTO tech_bucket_list VALUES(116,'sunset lastpass',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:15:52','2022-08-27 22:15:52');
INSERT INTO tech_bucket_list VALUES(117,'convert bitwardent to keepass',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:15:52','2022-08-27 22:15:52');
INSERT INTO tech_bucket_list VALUES(118,'use syncthing with keepass',NULL,NULL,NULL,NULL,NULL,NULL,'2022-08-27 22:15:52','2022-08-27 22:15:52');
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('tech_bucket_list',118);
COMMIT;