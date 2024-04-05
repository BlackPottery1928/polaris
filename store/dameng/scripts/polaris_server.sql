CREATE TABLE "SCFS"."auth_principal"
(
    "strategy_id"    VARCHAR(128) NOT NULL,
    "principal_id"   VARCHAR(128) NOT NULL,
    "principal_role" INT          NOT NULL,
    NOT              CLUSTER PRIMARY KEY("strategy_id", "principal_id", "principal_role")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."auth_principal"."principal_id" IS 'Principal ID';
COMMENT
ON COLUMN "SCFS"."auth_principal"."principal_role" IS 'PRINCIPAL type, 1 is User, 2 is Group';
COMMENT
ON COLUMN "SCFS"."auth_principal"."strategy_id" IS 'Strategy ID';


CREATE TABLE "SCFS"."auth_strategy"
(
    "id"       VARCHAR(128)                             NOT NULL,
    "name"     VARCHAR(100)                             NOT NULL,
    "action"   VARCHAR(32)                              NOT NULL,
    "owner"    VARCHAR(128)                             NOT NULL,
    "comment"  VARCHAR(255)                             NOT NULL,
    "default"  TINYINT      DEFAULT 0                   NOT NULL,
    "revision" VARCHAR(128)                             NOT NULL,
    "flag"     TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"    TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"    TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT        CLUSTER PRIMARY KEY("id"),
    UNIQUE ("name", "owner")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."auth_strategy"."action" IS 'Read and write permission for this policy, only_read = 0, read_write = 1';
COMMENT
ON COLUMN "SCFS"."auth_strategy"."comment" IS 'describe';
COMMENT
ON COLUMN "SCFS"."auth_strategy"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."auth_strategy"."flag" IS 'Whether the rules are valid, 0 is valid, 1 is invalid, it is deleted';
COMMENT
ON COLUMN "SCFS"."auth_strategy"."id" IS 'Strategy ID';
COMMENT
ON COLUMN "SCFS"."auth_strategy"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."auth_strategy"."name" IS 'Policy name';
COMMENT
ON COLUMN "SCFS"."auth_strategy"."owner" IS 'The account ID to which this policy is';
COMMENT
ON COLUMN "SCFS"."auth_strategy"."revision" IS 'Authentication rule version';


CREATE
OR REPLACE  INDEX "INDEX25985605337000" ON "SCFS"."auth_strategy"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25985615087000" ON "SCFS"."auth_strategy"("owner" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."auth_strategy_resource"
(
    "strategy_id" VARCHAR(128)                             NOT NULL,
    "res_type"    INT                                      NOT NULL,
    "res_id"      VARCHAR(128)                             NOT NULL,
    "ctime"       TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"       TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT           CLUSTER PRIMARY KEY("strategy_id", "res_type", "res_id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."auth_strategy_resource"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."auth_strategy_resource"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."auth_strategy_resource"."res_id" IS 'Resource ID';
COMMENT
ON COLUMN "SCFS"."auth_strategy_resource"."res_type" IS 'Resource Type, Namespaces = 0, Service = 1, configgroups = 2';
COMMENT
ON COLUMN "SCFS"."auth_strategy_resource"."strategy_id" IS 'Strategy ID';


CREATE
OR REPLACE  INDEX "mtime" ON "SCFS"."auth_strategy_resource"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."circuitbreaker_rule"
(
    "id"         VARCHAR(97)                              NOT NULL,
    "version"    VARCHAR(32)  DEFAULT 'master'            NOT NULL,
    "name"       VARCHAR(128)                             NOT NULL,
    "namespace"  VARCHAR(64)                              NOT NULL,
    "business"   VARCHAR(64),
    "department" VARCHAR(1024),
    "comment"    VARCHAR(1024),
    "inbounds"   TEXT                                     NOT NULL,
    "outbounds"  TEXT                                     NOT NULL,
    "token"      VARCHAR(32)                              NOT NULL,
    "owner"      VARCHAR(1024)                            NOT NULL,
    "revision"   VARCHAR(32)                              NOT NULL,
    "flag"       TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"      TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"      TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT          CLUSTER PRIMARY KEY("id", "version"),
    UNIQUE ("name", "namespace", "version")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."business" IS 'Business information of fuse regular';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."comment" IS 'Description of the fuse rule';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."department" IS 'Department information to which the fuse regular belongs';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."flag" IS 'Logic delete flag, 0 means visible, 1 means that it has been logically deleted';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."id" IS 'Melting rule ID';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."inbounds" IS 'Service-tuned fuse rule';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."name" IS 'Melting rule name';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."namespace" IS 'Melting rule belongs to name space';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."outbounds" IS 'Service Motoring Fuse Rule';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."owner" IS 'Melting rule Owner information';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."revision" IS 'Melt rule version information';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."token" IS 'Token, which is fucking, mainly for writing operation check';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule"."version" IS 'Melting rule version, default is MASTR';


CREATE
OR REPLACE  INDEX "INDEX25985624552600" ON "SCFS"."circuitbreaker_rule"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."circuitbreaker_rule_relation"
(
    "service_id"   VARCHAR(32)                              NOT NULL,
    "rule_id"      VARCHAR(97)                              NOT NULL,
    "rule_version" VARCHAR(32)                              NOT NULL,
    "flag"         TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT            CLUSTER PRIMARY KEY("service_id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule_relation"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule_relation"."flag" IS 'Logic delete flag, 0 means visible, 1 means that it has been logically deleted';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule_relation"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule_relation"."rule_id" IS 'Melting rule ID';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule_relation"."rule_version" IS 'Melting rule version';
COMMENT
ON COLUMN "SCFS"."circuitbreaker_rule_relation"."service_id" IS 'Service ID';


CREATE
OR REPLACE  INDEX "rule_id" ON "SCFS"."circuitbreaker_rule_relation"("rule_id" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25984667443600" ON "SCFS"."circuitbreaker_rule_relation"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."circuitbreaker_rule_v2"
(
    "id"            VARCHAR(128)                              NOT NULL,
    "name"          VARCHAR(64)                               NOT NULL,
    "namespace"     VARCHAR(64)   DEFAULT ''                  NOT NULL,
    "enable"        INT           DEFAULT 0                   NOT NULL,
    "revision"      VARCHAR(40)                               NOT NULL,
    "description"   VARCHAR(1024) DEFAULT ''                  NOT NULL,
    "level"         INT                                       NOT NULL,
    "src_service"   VARCHAR(128)                              NOT NULL,
    "src_namespace" VARCHAR(64)                               NOT NULL,
    "dst_service"   VARCHAR(128)                              NOT NULL,
    "dst_namespace" VARCHAR(64)                               NOT NULL,
    "dst_method"    VARCHAR(128)                              NOT NULL,
    "config"        TEXT,
    "flag"          TINYINT       DEFAULT 0                   NOT NULL,
    "ctime"         TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"         TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "etime"         TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT             CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

CREATE
OR REPLACE  INDEX "name" ON "SCFS"."circuitbreaker_rule_v2"("name" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25984685664900" ON "SCFS"."circuitbreaker_rule_v2"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."cl5_module"
(
    "module_id"    INT                                      NOT NULL,
    "interface_id" INT                                      NOT NULL,
    "range_num"    INT                                      NOT NULL,
    "mtime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT            CLUSTER PRIMARY KEY("module_id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON TABLE "SCFS"."cl5_module" IS 'To generate SID';
COMMENT
ON COLUMN "SCFS"."cl5_module"."interface_id" IS 'Interface ID';
COMMENT
ON COLUMN "SCFS"."cl5_module"."module_id" IS 'Module ID';
COMMENT
ON COLUMN "SCFS"."cl5_module"."mtime" IS 'Last updated time';


CREATE TABLE "SCFS"."client"
(
    "id"      VARCHAR(128)                             NOT NULL,
    "host"    VARCHAR(100)                             NOT NULL,
    "type"    VARCHAR(100)                             NOT NULL,
    "version" VARCHAR(32)                              NOT NULL,
    "region"  VARCHAR(128),
    "zone"    VARCHAR(128),
    "campus"  VARCHAR(128),
    "flag"    TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"   TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"   TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT       CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."client"."campus" IS 'campus info for client';
COMMENT
ON COLUMN "SCFS"."client"."ctime" IS 'create time';
COMMENT
ON COLUMN "SCFS"."client"."flag" IS '0 is valid, 1 is invalid(deleted)';
COMMENT
ON COLUMN "SCFS"."client"."host" IS 'client host IP';
COMMENT
ON COLUMN "SCFS"."client"."id" IS 'client id';
COMMENT
ON COLUMN "SCFS"."client"."mtime" IS 'last updated time';
COMMENT
ON COLUMN "SCFS"."client"."region" IS 'region info for client';
COMMENT
ON COLUMN "SCFS"."client"."type" IS 'client type: polaris-java/polaris-go';
COMMENT
ON COLUMN "SCFS"."client"."version" IS 'client SDK version';
COMMENT
ON COLUMN "SCFS"."client"."zone" IS 'zone info for client';


CREATE
OR REPLACE  INDEX "INDEX25984695433600" ON "SCFS"."client"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."client_stat"
(
    "client_id" VARCHAR(128) NOT NULL,
    "target"    VARCHAR(100) NOT NULL,
    "port"      INT          NOT NULL,
    "protocol"  VARCHAR(100) NOT NULL,
    "path"      VARCHAR(128) NOT NULL,
    NOT         CLUSTER PRIMARY KEY("client_id", "target", "port")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."client_stat"."client_id" IS 'client id';
COMMENT
ON COLUMN "SCFS"."client_stat"."path" IS 'stat metric path';
COMMENT
ON COLUMN "SCFS"."client_stat"."port" IS 'client port to get stat information';
COMMENT
ON COLUMN "SCFS"."client_stat"."protocol" IS 'stat info transport protocol';
COMMENT
ON COLUMN "SCFS"."client_stat"."target" IS 'target stat platform';


CREATE TABLE "SCFS"."config_file"
(
    "id"          BIGINT IDENTITY(1, 1) NOT NULL,
    "namespace"   VARCHAR(64)                              NOT NULL,
    "group"       VARCHAR(128) DEFAULT ''                  NOT NULL,
    "name"        VARCHAR(128)                             NOT NULL,
    "content"     CLOB                                     NOT NULL,
    "format"      VARCHAR(16)  DEFAULT 'text',
    "comment"     VARCHAR(512),
    "flag"        TINYINT      DEFAULT 0                   NOT NULL,
    "create_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "create_by"   VARCHAR(32),
    "modify_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "modify_by"   VARCHAR(32),
    NOT           CLUSTER PRIMARY KEY("id"),
    CONSTRAINT "uk_file" UNIQUE ("namespace", "group", "name")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON TABLE "SCFS"."config_file" IS '配置文件表';
COMMENT
ON COLUMN "SCFS"."config_file"."comment" IS '备注信息';
COMMENT
ON COLUMN "SCFS"."config_file"."content" IS '文件内容';
COMMENT
ON COLUMN "SCFS"."config_file"."create_by" IS '创建人';
COMMENT
ON COLUMN "SCFS"."config_file"."create_time" IS '创建时间';
COMMENT
ON COLUMN "SCFS"."config_file"."flag" IS '软删除标记位';
COMMENT
ON COLUMN "SCFS"."config_file"."format" IS '文件格式，枚举值';
COMMENT
ON COLUMN "SCFS"."config_file"."group" IS '所属的文件组';
COMMENT
ON COLUMN "SCFS"."config_file"."id" IS '主键';
COMMENT
ON COLUMN "SCFS"."config_file"."modify_by" IS '最后更新人';
COMMENT
ON COLUMN "SCFS"."config_file"."modify_time" IS '最后更新时间';
COMMENT
ON COLUMN "SCFS"."config_file"."name" IS '配置文件名';
COMMENT
ON COLUMN "SCFS"."config_file"."namespace" IS '所属的namespace';


CREATE TABLE "SCFS"."config_file_group"
(
    "id"          BIGINT IDENTITY(1, 1) NOT NULL,
    "name"        VARCHAR(128)                             NOT NULL,
    "namespace"   VARCHAR(64)                              NOT NULL,
    "comment"     VARCHAR(512),
    "owner"       VARCHAR(1024),
    "create_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "create_by"   VARCHAR(32),
    "modify_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "modify_by"   VARCHAR(32),
    "business"    VARCHAR(64),
    "department"  VARCHAR(1024),
    "metadata"    TEXT,
    "flag"        TINYINT      DEFAULT 0                   NOT NULL,
    NOT           CLUSTER PRIMARY KEY("id"),
    CONSTRAINT "uk_name" UNIQUE ("namespace", "name")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON TABLE "SCFS"."config_file_group" IS '配置文件组表';
COMMENT
ON COLUMN "SCFS"."config_file_group"."business" IS 'Service business information';
COMMENT
ON COLUMN "SCFS"."config_file_group"."comment" IS '备注信息';
COMMENT
ON COLUMN "SCFS"."config_file_group"."create_by" IS '创建人';
COMMENT
ON COLUMN "SCFS"."config_file_group"."create_time" IS '创建时间';
COMMENT
ON COLUMN "SCFS"."config_file_group"."department" IS 'Service department information';
COMMENT
ON COLUMN "SCFS"."config_file_group"."flag" IS '是否被删除';
COMMENT
ON COLUMN "SCFS"."config_file_group"."id" IS '主键';
COMMENT
ON COLUMN "SCFS"."config_file_group"."metadata" IS '配置分组标签';
COMMENT
ON COLUMN "SCFS"."config_file_group"."modify_by" IS '最后更新人';
COMMENT
ON COLUMN "SCFS"."config_file_group"."modify_time" IS '最后更新时间';
COMMENT
ON COLUMN "SCFS"."config_file_group"."name" IS '配置文件分组名';
COMMENT
ON COLUMN "SCFS"."config_file_group"."namespace" IS '所属的namespace';
COMMENT
ON COLUMN "SCFS"."config_file_group"."owner" IS '负责人';


CREATE TABLE "SCFS"."config_file_release"
(
    "id"           BIGINT IDENTITY(1, 1) NOT NULL,
    "name"         VARCHAR(128),
    "namespace"    VARCHAR(64)                              NOT NULL,
    "group"        VARCHAR(128)                             NOT NULL,
    "file_name"    VARCHAR(128)                             NOT NULL,
    "format"       VARCHAR(16)  DEFAULT 'text',
    "content"      CLOB                                     NOT NULL,
    "comment"      VARCHAR(512),
    "md5"          VARCHAR(128)                             NOT NULL,
    "version"      BIGINT                                   NOT NULL,
    "flag"         TINYINT      DEFAULT 0                   NOT NULL,
    "create_time"  TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "create_by"    VARCHAR(32),
    "modify_time"  TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "modify_by"    VARCHAR(32),
    "tags"         TEXT,
    "active"       TINYINT      DEFAULT 0                   NOT NULL,
    "description"  VARCHAR(512),
    "release_type" VARCHAR(25)  DEFAULT ''                  NOT NULL,
    NOT            CLUSTER PRIMARY KEY("id"),
    UNIQUE ("namespace", "group", "file_name", "name")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON TABLE "SCFS"."config_file_release" IS '配置文件发布表';
COMMENT
ON COLUMN "SCFS"."config_file_release"."active" IS '是否处于使用中';
COMMENT
ON COLUMN "SCFS"."config_file_release"."comment" IS '备注信息';
COMMENT
ON COLUMN "SCFS"."config_file_release"."content" IS '文件内容';
COMMENT
ON COLUMN "SCFS"."config_file_release"."create_by" IS '创建人';
COMMENT
ON COLUMN "SCFS"."config_file_release"."create_time" IS '创建时间';
COMMENT
ON COLUMN "SCFS"."config_file_release"."description" IS '发布描述';
COMMENT
ON COLUMN "SCFS"."config_file_release"."file_name" IS '配置文件名';
COMMENT
ON COLUMN "SCFS"."config_file_release"."flag" IS '是否被删除';
COMMENT
ON COLUMN "SCFS"."config_file_release"."format" IS '文件格式，枚举值';
COMMENT
ON COLUMN "SCFS"."config_file_release"."group" IS '所属的文件组';
COMMENT
ON COLUMN "SCFS"."config_file_release"."id" IS '主键';
COMMENT
ON COLUMN "SCFS"."config_file_release"."md5" IS 'content的md5值';
COMMENT
ON COLUMN "SCFS"."config_file_release"."modify_by" IS '最后更新人';
COMMENT
ON COLUMN "SCFS"."config_file_release"."modify_time" IS '最后更新时间';
COMMENT
ON COLUMN "SCFS"."config_file_release"."name" IS '发布标题';
COMMENT
ON COLUMN "SCFS"."config_file_release"."namespace" IS '所属的namespace';
COMMENT
ON COLUMN "SCFS"."config_file_release"."release_type" IS '文件类型：""：全量 gray：灰度';
COMMENT
ON COLUMN "SCFS"."config_file_release"."tags" IS '文件标签';
COMMENT
ON COLUMN "SCFS"."config_file_release"."version" IS '版本号，每次发布自增1';


CREATE
OR REPLACE  INDEX "idx_modify_time" ON "SCFS"."config_file_release"("modify_time" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."config_file_release_history"
(
    "id"          BIGINT IDENTITY(1, 1) NOT NULL,
    "name"        VARCHAR(64)   DEFAULT '',
    "namespace"   VARCHAR(64)                               NOT NULL,
    "group"       VARCHAR(128)                              NOT NULL,
    "file_name"   VARCHAR(128)                              NOT NULL,
    "content"     CLOB                                      NOT NULL,
    "format"      VARCHAR(16)   DEFAULT 'text',
    "comment"     VARCHAR(512),
    "md5"         VARCHAR(128)                              NOT NULL,
    "type"        VARCHAR(32)                               NOT NULL,
    "status"      VARCHAR(16)   DEFAULT 'success'           NOT NULL,
    "create_time" TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "create_by"   VARCHAR(32),
    "modify_time" TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "modify_by"   VARCHAR(32),
    "tags"        TEXT,
    "version"     BIGINT,
    "reason"      VARCHAR(3000) DEFAULT '',
    "description" VARCHAR(512),
    NOT           CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON TABLE "SCFS"."config_file_release_history" IS '配置文件发布历史表';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."comment" IS '备注信息';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."content" IS '文件内容';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."create_by" IS '创建人';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."create_time" IS '创建时间';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."description" IS '发布描述';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."file_name" IS '配置文件名';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."format" IS '文件格式';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."group" IS '所属的文件组';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."id" IS '主键';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."md5" IS 'content的md5值';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."modify_by" IS '最后更新人';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."modify_time" IS '最后更新时间';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."name" IS '发布名称';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."namespace" IS '所属的namespace';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."reason" IS '原因';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."status" IS '发布状态，success表示成功，fail 表示失败';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."tags" IS '文件标签';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."type" IS '发布类型，例如全量发布、灰度发布';
COMMENT
ON COLUMN "SCFS"."config_file_release_history"."version" IS '版本号，每次发布自增1';


CREATE
OR REPLACE  INDEX "idx_file" ON "SCFS"."config_file_release_history"("namespace" ASC,"group" ASC,"file_name" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."config_file_tag"
(
    "id"          BIGINT IDENTITY(1, 1) NOT NULL,
    "key"         VARCHAR(128)                             NOT NULL,
    "Value"       VARCHAR(128)                             NOT NULL,
    "namespace"   VARCHAR(64)                              NOT NULL,
    "group"       VARCHAR(128) DEFAULT ''                  NOT NULL,
    "file_name"   VARCHAR(128)                             NOT NULL,
    "create_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "create_by"   VARCHAR(32),
    "modify_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "modify_by"   VARCHAR(32),
    NOT           CLUSTER PRIMARY KEY("id"),
    CONSTRAINT "uk_tag" UNIQUE ("key", "Value", "namespace", "group", "file_name")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON TABLE "SCFS"."config_file_tag" IS '配置文件标签表';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."Value" IS 'tag 的值';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."create_by" IS '创建人';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."create_time" IS '创建时间';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."file_name" IS '配置文件名';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."group" IS '所属的文件组';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."id" IS '主键';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."key" IS 'tag 的键';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."modify_by" IS '最后更新人';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."modify_time" IS '最后更新时间';
COMMENT
ON COLUMN "SCFS"."config_file_tag"."namespace" IS '所属的namespace';


CREATE
OR REPLACE  INDEX "INDEX25985643797500" ON "SCFS"."config_file_tag"("namespace" ASC,"group" ASC,"file_name" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."config_file_template"
(
    "id"          BIGINT IDENTITY(2, 1) NOT NULL,
    "name"        VARCHAR(128)                             NOT NULL,
    "content"     CLOB                                     NOT NULL,
    "format"      VARCHAR(16)  DEFAULT 'text',
    "comment"     VARCHAR(512),
    "create_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "create_by"   VARCHAR(32),
    "modify_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "modify_by"   VARCHAR(32),
    NOT           CLUSTER PRIMARY KEY("id"),
    UNIQUE ("name")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON TABLE "SCFS"."config_file_template" IS '配置文件模板表';
COMMENT
ON COLUMN "SCFS"."config_file_template"."comment" IS '模板描述信息';
COMMENT
ON COLUMN "SCFS"."config_file_template"."content" IS '配置文件模板内容';
COMMENT
ON COLUMN "SCFS"."config_file_template"."create_by" IS '创建人';
COMMENT
ON COLUMN "SCFS"."config_file_template"."create_time" IS '创建时间';
COMMENT
ON COLUMN "SCFS"."config_file_template"."format" IS '模板文件格式';
COMMENT
ON COLUMN "SCFS"."config_file_template"."id" IS '主键';
COMMENT
ON COLUMN "SCFS"."config_file_template"."modify_by" IS '最后更新人';
COMMENT
ON COLUMN "SCFS"."config_file_template"."modify_time" IS '最后更新时间';
COMMENT
ON COLUMN "SCFS"."config_file_template"."name" IS '配置文件模板名称';


CREATE TABLE "SCFS"."fault_detect_rule"
(
    "id"            VARCHAR(128)                              NOT NULL,
    "name"          VARCHAR(64)                               NOT NULL,
    "namespace"     VARCHAR(64)   DEFAULT 'default'           NOT NULL,
    "revision"      VARCHAR(40)                               NOT NULL,
    "description"   VARCHAR(1024) DEFAULT ''                  NOT NULL,
    "dst_service"   VARCHAR(128)                              NOT NULL,
    "dst_namespace" VARCHAR(64)                               NOT NULL,
    "dst_method"    VARCHAR(128)                              NOT NULL,
    "config"        TEXT,
    "flag"          TINYINT       DEFAULT 0                   NOT NULL,
    "ctime"         TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"         TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT             CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

CREATE
OR REPLACE  INDEX "INDEX25984714030200" ON "SCFS"."fault_detect_rule"("name" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25984723704900" ON "SCFS"."fault_detect_rule"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."gray_resource"
(
    "name"        VARCHAR(128)                             NOT NULL,
    "match_rule"  TEXT                                     NOT NULL,
    "create_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "create_by"   VARCHAR(32)  DEFAULT '',
    "modify_time" TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "modify_by"   VARCHAR(32)  DEFAULT '',
    "flag"        TINYINT      DEFAULT 0,
    NOT           CLUSTER PRIMARY KEY("name")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON TABLE "SCFS"."gray_resource" IS '灰度资源表';
COMMENT
ON COLUMN "SCFS"."gray_resource"."create_by" IS '创建人';
COMMENT
ON COLUMN "SCFS"."gray_resource"."create_time" IS '创建时间';
COMMENT
ON COLUMN "SCFS"."gray_resource"."flag" IS '逻辑删除标志位, 0 位有效, 1 为逻辑删除';
COMMENT
ON COLUMN "SCFS"."gray_resource"."match_rule" IS '配置规则';
COMMENT
ON COLUMN "SCFS"."gray_resource"."modify_by" IS '最后更新人';
COMMENT
ON COLUMN "SCFS"."gray_resource"."modify_time" IS '最后更新时间';
COMMENT
ON COLUMN "SCFS"."gray_resource"."name" IS '灰度资源';


CREATE TABLE "SCFS"."health_check"
(
    "id"   VARCHAR(128)      NOT NULL,
    "type" TINYINT DEFAULT 0 NOT NULL,
    "ttl"  INT               NOT NULL,
    NOT    CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."health_check"."id" IS 'Instance ID';
COMMENT
ON COLUMN "SCFS"."health_check"."ttl" IS 'TTL time jumping';
COMMENT
ON COLUMN "SCFS"."health_check"."type" IS 'Instance health check type';


CREATE TABLE "SCFS"."instance"
(
    "id"                  VARCHAR(128)                             NOT NULL,
    "service_id"          VARCHAR(32)                              NOT NULL,
    "vpc_id"              VARCHAR(64),
    "host"                VARCHAR(128)                             NOT NULL,
    "port"                INT                                      NOT NULL,
    "protocol"            VARCHAR(32),
    "version"             VARCHAR(32),
    "health_status"       TINYINT      DEFAULT 1                   NOT NULL,
    "isolate"             TINYINT      DEFAULT 0                   NOT NULL,
    "weight"              SMALLINT     DEFAULT 100                 NOT NULL,
    "enable_health_check" TINYINT      DEFAULT 0                   NOT NULL,
    "logic_set"           VARCHAR(128),
    "cmdb_region"         VARCHAR(128),
    "cmdb_zone"           VARCHAR(128),
    "cmdb_idc"            VARCHAR(128),
    "priority"            TINYINT      DEFAULT 0                   NOT NULL,
    "revision"            VARCHAR(32)                              NOT NULL,
    "flag"                TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"               TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"               TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT                   CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."instance"."cmdb_idc" IS 'The IDC information of the instance is mainly used to close the route';
COMMENT
ON COLUMN "SCFS"."instance"."cmdb_region" IS 'The region information of the instance is mainly used to close the route';
COMMENT
ON COLUMN "SCFS"."instance"."cmdb_zone" IS 'The ZONE information of the instance is mainly used to close the route.';
COMMENT
ON COLUMN "SCFS"."instance"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."instance"."enable_health_check" IS 'Whether to open a heartbeat on an instance, check the logic, 0 is not open, 1 is open';
COMMENT
ON COLUMN "SCFS"."instance"."flag" IS 'Logic delete flag, 0 means visible, 1 means that it has been logically deleted';
COMMENT
ON COLUMN "SCFS"."instance"."health_status" IS 'The health status of the instance, 1 is health, 0 is unhealthy';
COMMENT
ON COLUMN "SCFS"."instance"."host" IS 'instance Host Information';
COMMENT
ON COLUMN "SCFS"."instance"."id" IS 'Unique ID';
COMMENT
ON COLUMN "SCFS"."instance"."isolate" IS 'Example isolation status flag, 0 is not isolated, 1 is isolated';
COMMENT
ON COLUMN "SCFS"."instance"."logic_set" IS 'Example logic packet information';
COMMENT
ON COLUMN "SCFS"."instance"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."instance"."port" IS 'instance port information';
COMMENT
ON COLUMN "SCFS"."instance"."priority" IS 'Example priority, currently useless';
COMMENT
ON COLUMN "SCFS"."instance"."protocol" IS 'Listening protocols for corresponding ports, such as TPC, UDP, GRPC, DUBBO, etc.';
COMMENT
ON COLUMN "SCFS"."instance"."revision" IS 'Instance version information';
COMMENT
ON COLUMN "SCFS"."instance"."service_id" IS 'Service ID';
COMMENT
ON COLUMN "SCFS"."instance"."version" IS 'The version of the instance can be used for version routing';
COMMENT
ON COLUMN "SCFS"."instance"."vpc_id" IS 'VPC ID';
COMMENT
ON COLUMN "SCFS"."instance"."weight" IS 'The weight of the instance is mainly used for LoadBalance, default is 100';


CREATE
OR REPLACE  INDEX "host" ON "SCFS"."instance"("host" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "service_id" ON "SCFS"."instance"("service_id" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25984774691600" ON "SCFS"."instance"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."instance_metadata"
(
    "id"     VARCHAR(128)                             NOT NULL,
    "mkey"   VARCHAR(128)                             NOT NULL,
    "mvalue" VARCHAR(4096)                            NOT NULL,
    "ctime"  TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"  TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT      CLUSTER PRIMARY KEY("id", "mkey")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."instance_metadata"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."instance_metadata"."id" IS 'Instance ID';
COMMENT
ON COLUMN "SCFS"."instance_metadata"."mkey" IS 'instance label of Key';
COMMENT
ON COLUMN "SCFS"."instance_metadata"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."instance_metadata"."mvalue" IS 'instance label Value';


CREATE
OR REPLACE  INDEX "mkey" ON "SCFS"."instance_metadata"("mkey" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."leader_election"
(
    "elect_key" VARCHAR(128)                             NOT NULL,
    "version"   BIGINT       DEFAULT 0                   NOT NULL,
    "leader"    VARCHAR(128)                             NOT NULL,
    "ctime"     TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"     TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT         CLUSTER PRIMARY KEY("elect_key")
) STORAGE(ON "MAIN", CLUSTERBTR);

CREATE
OR REPLACE  INDEX "version" ON "SCFS"."leader_election"("version" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."namespace"
(
    "name"              VARCHAR(64)                              NOT NULL,
    "comment"           VARCHAR(1024),
    "token"             VARCHAR(64)                              NOT NULL,
    "owner"             VARCHAR(1024)                            NOT NULL,
    "flag"              TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"             TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"             TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "service_export_to" TEXT,
    "metadata"          TEXT,
    NOT                 CLUSTER PRIMARY KEY("name")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."namespace"."comment" IS 'Description of namespace';
COMMENT
ON COLUMN "SCFS"."namespace"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."namespace"."flag" IS 'Logic delete flag, 0 means visible, 1 means that it has been logically deleted';
COMMENT
ON COLUMN "SCFS"."namespace"."metadata" IS 'namespace metadata';
COMMENT
ON COLUMN "SCFS"."namespace"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."namespace"."name" IS 'Namespace name, unique';
COMMENT
ON COLUMN "SCFS"."namespace"."owner" IS 'Responsible for named space Owner';
COMMENT
ON COLUMN "SCFS"."namespace"."service_export_to" IS 'namespace metadata';
COMMENT
ON COLUMN "SCFS"."namespace"."token" IS 'TOKEN named space for write operation check';


CREATE TABLE "SCFS"."owner_service_map"
(
    "id"        VARCHAR(32)  NOT NULL,
    "owner"     VARCHAR(32)  NOT NULL,
    "service"   VARCHAR(128) NOT NULL,
    "namespace" VARCHAR(64)  NOT NULL,
    NOT         CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."owner_service_map"."namespace" IS 'namespace name';
COMMENT
ON COLUMN "SCFS"."owner_service_map"."owner" IS 'Service Owner';
COMMENT
ON COLUMN "SCFS"."owner_service_map"."service" IS 'service name';


CREATE
OR REPLACE  INDEX "owner" ON "SCFS"."owner_service_map"("owner" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25984813640500" ON "SCFS"."owner_service_map"("service" ASC,"namespace" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."ratelimit_config"
(
    "id"         VARCHAR(32)                              NOT NULL,
    "name"       VARCHAR(64)                              NOT NULL,
    "disable"    TINYINT      DEFAULT 0                   NOT NULL,
    "service_id" VARCHAR(32)                              NOT NULL,
    "method"     VARCHAR(512)                             NOT NULL,
    "labels"     TEXT                                     NOT NULL,
    "priority"   SMALLINT     DEFAULT 0                   NOT NULL,
    "rule"       TEXT                                     NOT NULL,
    "revision"   VARCHAR(32)                              NOT NULL,
    "flag"       TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"      TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"      TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "etime"      TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT          CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."ratelimit_config"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."disable" IS 'ratelimit disable';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."etime" IS 'RateLimit rule enable time';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."flag" IS 'Logic delete flag, 0 means visible, 1 means that it has been logically deleted';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."id" IS 'ratelimit rule ID';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."labels" IS 'Conductive flow for a specific label';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."method" IS 'ratelimit method';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."name" IS 'ratelimt rule name';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."priority" IS 'ratelimit rule priority';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."revision" IS 'Limiting version';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."rule" IS 'Current limiting rules';
COMMENT
ON COLUMN "SCFS"."ratelimit_config"."service_id" IS 'Service ID';


CREATE
OR REPLACE  INDEX "INDEX25984823106800" ON "SCFS"."ratelimit_config"("service_id" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25984832838900" ON "SCFS"."ratelimit_config"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."ratelimit_revision"
(
    "service_id"    VARCHAR(32)                              NOT NULL,
    "last_revision" VARCHAR(40)                              NOT NULL,
    "mtime"         TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT             CLUSTER PRIMARY KEY("service_id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."ratelimit_revision"."last_revision" IS 'The latest limited limiting rule version of the corresponding service';
COMMENT
ON COLUMN "SCFS"."ratelimit_revision"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."ratelimit_revision"."service_id" IS 'Service ID';


CREATE
OR REPLACE  INDEX "INDEX25984842029300" ON "SCFS"."ratelimit_revision"("service_id" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25984850957200" ON "SCFS"."ratelimit_revision"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."routing_config"
(
    "id"         VARCHAR(32)                              NOT NULL,
    "in_bounds"  TEXT,
    "out_bounds" TEXT,
    "revision"   VARCHAR(40)                              NOT NULL,
    "flag"       TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"      TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"      TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT          CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."routing_config"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."routing_config"."flag" IS 'Logic delete flag, 0 means visible, 1 means that it has been logically deleted';
COMMENT
ON COLUMN "SCFS"."routing_config"."id" IS 'Routing configuration ID';
COMMENT
ON COLUMN "SCFS"."routing_config"."in_bounds" IS 'Service is routing rules';
COMMENT
ON COLUMN "SCFS"."routing_config"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."routing_config"."out_bounds" IS 'Service main routing rules';
COMMENT
ON COLUMN "SCFS"."routing_config"."revision" IS 'Routing rule version';


CREATE
OR REPLACE  INDEX "INDEX25984860062900" ON "SCFS"."routing_config"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."routing_config_v2"
(
    "id"          VARCHAR(128)                              NOT NULL,
    "name"        VARCHAR(64)   DEFAULT ''                  NOT NULL,
    "namespace"   VARCHAR(64)   DEFAULT ''                  NOT NULL,
    "policy"      VARCHAR(64)                               NOT NULL,
    "config"      TEXT,
    "enable"      INT           DEFAULT 0                   NOT NULL,
    "revision"    VARCHAR(40)                               NOT NULL,
    "description" VARCHAR(500)  DEFAULT ''                  NOT NULL,
    "priority"    SMALLINT      DEFAULT 0                   NOT NULL,
    "flag"        TINYINT       DEFAULT 0                   NOT NULL,
    "ctime"       TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"       TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "etime"       TIMESTAMP(0)  DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "extend_info" VARCHAR(1024) DEFAULT '',
    NOT           CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."routing_config_v2"."priority" IS 'ratelimit rule priority';


CREATE
OR REPLACE  INDEX "INDEX25984869770200" ON "SCFS"."routing_config_v2"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."service"
(
    "id"           VARCHAR(32)                              NOT NULL,
    "name"         VARCHAR(128)                             NOT NULL,
    "namespace"    VARCHAR(64)                              NOT NULL,
    "ports"        TEXT,
    "business"     VARCHAR(64),
    "department"   VARCHAR(1024),
    "cmdb_mod1"    VARCHAR(1024),
    "cmdb_mod2"    VARCHAR(1024),
    "cmdb_mod3"    VARCHAR(1024),
    "comment"      VARCHAR(1024),
    "token"        VARCHAR(2048)                            NOT NULL,
    "revision"     VARCHAR(32)                              NOT NULL,
    "owner"        VARCHAR(1024)                            NOT NULL,
    "flag"         TINYINT      DEFAULT 0                   NOT NULL,
    "reference"    VARCHAR(32),
    "refer_filter" VARCHAR(1024),
    "platform_id"  VARCHAR(32)  DEFAULT '',
    "ctime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "export_to"    TEXT,
    NOT            CLUSTER PRIMARY KEY("id"),
    UNIQUE ("name", "namespace")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."service"."business" IS 'Service business information';
COMMENT
ON COLUMN "SCFS"."service"."comment" IS 'Description information';
COMMENT
ON COLUMN "SCFS"."service"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."service"."department" IS 'Service department information';
COMMENT
ON COLUMN "SCFS"."service"."export_to" IS 'service export to some namespace';
COMMENT
ON COLUMN "SCFS"."service"."flag" IS 'Logic delete flag, 0 means visible, 1 means that it has been logically deleted';
COMMENT
ON COLUMN "SCFS"."service"."id" IS 'Service ID';
COMMENT
ON COLUMN "SCFS"."service"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."service"."name" IS 'Service name, only under the namespace';
COMMENT
ON COLUMN "SCFS"."service"."namespace" IS 'Namespace belongs to the service';
COMMENT
ON COLUMN "SCFS"."service"."owner" IS 'Owner information belonging to the service';
COMMENT
ON COLUMN "SCFS"."service"."platform_id" IS 'The platform ID to which the service belongs';
COMMENT
ON COLUMN "SCFS"."service"."ports" IS 'Service will have a list of all port information of the external exposure (single process exposing multiple protocols)';
COMMENT
ON COLUMN "SCFS"."service"."reference" IS 'Service alias, what is the actual service name that the service is actually pointed out?';
COMMENT
ON COLUMN "SCFS"."service"."revision" IS 'Service version information';
COMMENT
ON COLUMN "SCFS"."service"."token" IS 'Service token, used to handle all the services involved in the service';


CREATE
OR REPLACE  INDEX "INDEX25985653091900" ON "SCFS"."service"("namespace" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "reference" ON "SCFS"."service"("reference" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "platform_id" ON "SCFS"."service"("platform_id" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25985681232300" ON "SCFS"."service"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."service_contract"
(
    "id"        VARCHAR(128)                             NOT NULL,
    "name"      VARCHAR(128)                             NOT NULL,
    "namespace" VARCHAR(64)                              NOT NULL,
    "service"   VARCHAR(128)                             NOT NULL,
    "protocol"  VARCHAR(32)                              NOT NULL,
    "version"   VARCHAR(64)                              NOT NULL,
    "revision"  VARCHAR(128)                             NOT NULL,
    "flag"      TINYINT      DEFAULT 0,
    "content"   CLOB,
    "ctime"     TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"     TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT         CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."service_contract"."content" IS '描述信息';
COMMENT
ON COLUMN "SCFS"."service_contract"."flag" IS '逻辑删除标志位 ， 0 位有效 ， 1 为逻辑删除';
COMMENT
ON COLUMN "SCFS"."service_contract"."id" IS '服务契约主键';
COMMENT
ON COLUMN "SCFS"."service_contract"."name" IS '服务契约名称';
COMMENT
ON COLUMN "SCFS"."service_contract"."namespace" IS '命名空间';
COMMENT
ON COLUMN "SCFS"."service_contract"."protocol" IS '当前契约对应的协议信息 e.g. http/dubbo/grpc/thrift';
COMMENT
ON COLUMN "SCFS"."service_contract"."revision" IS '当前服务契约的全部内容版本摘要';
COMMENT
ON COLUMN "SCFS"."service_contract"."service" IS '服务名称';
COMMENT
ON COLUMN "SCFS"."service_contract"."version" IS '服务契约版本';


CREATE
OR REPLACE  INDEX "namespace" ON "SCFS"."service_contract"("namespace" ASC,"service" ASC,"name" ASC,"version" ASC,"protocol" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."service_contract_detail"
(
    "id"          VARCHAR(128)                             NOT NULL,
    "contract_id" VARCHAR(128)                             NOT NULL,
    "name"        VARCHAR(128)                             NOT NULL,
    "method"      VARCHAR(32)                              NOT NULL,
    "path"        VARCHAR(128)                             NOT NULL,
    "source"      INT,
    "content"     CLOB,
    "revision"    VARCHAR(128)                             NOT NULL,
    "flag"        TINYINT      DEFAULT 0,
    "ctime"       TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"       TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT           CLUSTER PRIMARY KEY("id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."service_contract_detail"."content" IS '描述信息';
COMMENT
ON COLUMN "SCFS"."service_contract_detail"."contract_id" IS '服务契约 ID';
COMMENT
ON COLUMN "SCFS"."service_contract_detail"."flag" IS '逻辑删除标志位, 0 位有效, 1 为逻辑删除';
COMMENT
ON COLUMN "SCFS"."service_contract_detail"."id" IS '服务契约单个接口定义记录主键';
COMMENT
ON COLUMN "SCFS"."service_contract_detail"."method" IS 'http协议中的 method 字段, eg:POST/GET/PUT/DELETE, 其他 gRPC 可以用来标识 stream 类型';
COMMENT
ON COLUMN "SCFS"."service_contract_detail"."name" IS '服务契约接口名称';
COMMENT
ON COLUMN "SCFS"."service_contract_detail"."path" IS '接口具体全路径描述';
COMMENT
ON COLUMN "SCFS"."service_contract_detail"."revision" IS '当前接口定义的全部内容版本摘要';
COMMENT
ON COLUMN "SCFS"."service_contract_detail"."source" IS '该条记录来源, 0:SDK/1:MANUAL';


CREATE
OR REPLACE  INDEX "contract_id" ON "SCFS"."service_contract_detail"("contract_id" ASC,"path" ASC,"method" ASC,"source" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."service_metadata"
(
    "id"     VARCHAR(32)                              NOT NULL,
    "mkey"   VARCHAR(128)                             NOT NULL,
    "mvalue" VARCHAR(4096)                            NOT NULL,
    "ctime"  TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"  TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT      CLUSTER PRIMARY KEY("id", "mkey")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."service_metadata"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."service_metadata"."id" IS 'Service ID';
COMMENT
ON COLUMN "SCFS"."service_metadata"."mkey" IS 'Service label key';
COMMENT
ON COLUMN "SCFS"."service_metadata"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."service_metadata"."mvalue" IS 'Service label Value';


CREATE
OR REPLACE  INDEX "INDEX25984896882900" ON "SCFS"."service_metadata"("mkey" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."start_lock"
(
    "lock_id"  INT                                      NOT NULL,
    "lock_key" VARCHAR(32)                              NOT NULL,
    "server"   VARCHAR(32)                              NOT NULL,
    "mtime"    TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT        CLUSTER PRIMARY KEY("lock_id", "lock_key")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."start_lock"."lock_id" IS '锁序号';
COMMENT
ON COLUMN "SCFS"."start_lock"."lock_key" IS 'Lock name';
COMMENT
ON COLUMN "SCFS"."start_lock"."mtime" IS 'Update time';
COMMENT
ON COLUMN "SCFS"."start_lock"."server" IS 'SERVER holding launch lock';


CREATE TABLE "SCFS"."t_ip_config"
(
    "Fip"     BIGINT       NOT NULL,
    "FareaId" BIGINT       NOT NULL,
    "FcityId" BIGINT       NOT NULL,
    "FidcId"  BIGINT       NOT NULL,
    "Fflag"   TINYINT DEFAULT 0,
    "Fstamp"  TIMESTAMP(0) NOT NULL,
    "Fflow"   BIGINT       NOT NULL,
    NOT       CLUSTER PRIMARY KEY("Fip"),
    CHECK ("Fip" >= 0),
    CHECK ("FareaId" >= 0),
    CHECK ("FcityId" >= 0),
    CHECK ("FidcId" >= 0),
    CHECK ("Fflow" >= 0)
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."t_ip_config"."FareaId" IS 'Area number';
COMMENT
ON COLUMN "SCFS"."t_ip_config"."FcityId" IS 'City number';
COMMENT
ON COLUMN "SCFS"."t_ip_config"."FidcId" IS 'IDC number';
COMMENT
ON COLUMN "SCFS"."t_ip_config"."Fip" IS 'Machine IP';


CREATE
OR REPLACE  INDEX "idx_Fflow" ON "SCFS"."t_ip_config"("Fflow" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."t_policy"
(
    "FmodId" BIGINT       NOT NULL,
    "Fdiv"   BIGINT       NOT NULL,
    "Fmod"   BIGINT       NOT NULL,
    "Fflag"  TINYINT DEFAULT 0,
    "Fstamp" TIMESTAMP(0) NOT NULL,
    "Fflow"  BIGINT       NOT NULL,
    NOT      CLUSTER PRIMARY KEY("FmodId"),
    CHECK ("FmodId" >= 0),
    CHECK ("Fdiv" >= 0),
    CHECK ("Fmod" >= 0),
    CHECK ("Fflow" >= 0)
) STORAGE(ON "MAIN", CLUSTERBTR);

CREATE TABLE "SCFS"."t_route"
(
    "Fip"    BIGINT       NOT NULL,
    "FmodId" BIGINT       NOT NULL,
    "FcmdId" BIGINT       NOT NULL,
    "FsetId" VARCHAR(32)  NOT NULL,
    "Fflag"  TINYINT DEFAULT 0,
    "Fstamp" TIMESTAMP(0) NOT NULL,
    "Fflow"  BIGINT       NOT NULL,
    NOT      CLUSTER PRIMARY KEY("Fip", "FmodId", "FcmdId"),
    CHECK ("Fip" >= 0),
    CHECK ("FmodId" >= 0),
    CHECK ("FcmdId" >= 0),
    CHECK ("Fflow" >= 0)
) STORAGE(ON "MAIN", CLUSTERBTR);

CREATE
OR REPLACE  INDEX "idx1" ON "SCFS"."t_route"("FmodId" ASC,"FcmdId" ASC,"FsetId" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "Fflow" ON "SCFS"."t_route"("Fflow" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."t_section"
(
    "FmodId" BIGINT       NOT NULL,
    "Ffrom"  BIGINT       NOT NULL,
    "Fto"    BIGINT       NOT NULL,
    "Fxid"   BIGINT       NOT NULL,
    "Fflag"  TINYINT DEFAULT 0,
    "Fstamp" TIMESTAMP(0) NOT NULL,
    "Fflow"  BIGINT       NOT NULL,
    NOT      CLUSTER PRIMARY KEY("FmodId", "Ffrom", "Fto"),
    CHECK ("FmodId" >= 0),
    CHECK ("Ffrom" >= 0),
    CHECK ("Fto" >= 0),
    CHECK ("Fxid" >= 0),
    CHECK ("Fflow" >= 0)
) STORAGE(ON "MAIN", CLUSTERBTR);

CREATE TABLE "SCFS"."user"
(
    "id"           VARCHAR(128)                             NOT NULL,
    "name"         VARCHAR(100)                             NOT NULL,
    "password"     VARCHAR(100)                             NOT NULL,
    "owner"        VARCHAR(128)                             NOT NULL,
    "source"       VARCHAR(32)                              NOT NULL,
    "mobile"       VARCHAR(12)  DEFAULT ''                  NOT NULL,
    "email"        VARCHAR(64)  DEFAULT ''                  NOT NULL,
    "token"        VARCHAR(255)                             NOT NULL,
    "token_enable" TINYINT      DEFAULT 1                   NOT NULL,
    "user_type"    INT          DEFAULT 20                  NOT NULL,
    "comment"      VARCHAR(255)                             NOT NULL,
    "flag"         TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT            CLUSTER PRIMARY KEY("id"),
    UNIQUE ("name", "owner")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."user"."comment" IS 'describe';
COMMENT
ON COLUMN "SCFS"."user"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."user"."email" IS 'Account mailbox';
COMMENT
ON COLUMN "SCFS"."user"."flag" IS 'Whether the rules are valid, 0 is valid, 1 is invalid, it is deleted';
COMMENT
ON COLUMN "SCFS"."user"."id" IS 'User ID';
COMMENT
ON COLUMN "SCFS"."user"."mobile" IS 'Account mobile phone number';
COMMENT
ON COLUMN "SCFS"."user"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."user"."name" IS 'user name';
COMMENT
ON COLUMN "SCFS"."user"."owner" IS 'Main account ID';
COMMENT
ON COLUMN "SCFS"."user"."password" IS 'user password';
COMMENT
ON COLUMN "SCFS"."user"."source" IS 'Account source';
COMMENT
ON COLUMN "SCFS"."user"."token" IS 'The token information owned by the account can be used for SDK access authentication';
COMMENT
ON COLUMN "SCFS"."user"."user_type" IS 'Account type, 0 is the admin super account, 20 is the primary account, 50 for the child account';


CREATE
OR REPLACE  INDEX "INDEX25985718083800" ON "SCFS"."user"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25985727385000" ON "SCFS"."user"("owner" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."user_group"
(
    "id"           VARCHAR(128)                             NOT NULL,
    "name"         VARCHAR(100)                             NOT NULL,
    "owner"        VARCHAR(128)                             NOT NULL,
    "token"        VARCHAR(255)                             NOT NULL,
    "comment"      VARCHAR(255)                             NOT NULL,
    "token_enable" TINYINT      DEFAULT 1                   NOT NULL,
    "flag"         TINYINT      DEFAULT 0                   NOT NULL,
    "ctime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"        TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT            CLUSTER PRIMARY KEY("id"),
    UNIQUE ("name", "owner")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."user_group"."comment" IS 'Description';
COMMENT
ON COLUMN "SCFS"."user_group"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."user_group"."flag" IS 'Whether the rules are valid, 0 is valid, 1 is invalid, it is deleted';
COMMENT
ON COLUMN "SCFS"."user_group"."id" IS 'User group ID';
COMMENT
ON COLUMN "SCFS"."user_group"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."user_group"."name" IS 'User group name';
COMMENT
ON COLUMN "SCFS"."user_group"."owner" IS 'The main account ID of the user group';
COMMENT
ON COLUMN "SCFS"."user_group"."token" IS 'TOKEN information of this user group';


CREATE
OR REPLACE  INDEX "INDEX25985737326400" ON "SCFS"."user_group"("owner" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;
CREATE
OR REPLACE  INDEX "INDEX25985746567800" ON "SCFS"."user_group"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;

CREATE TABLE "SCFS"."user_group_relation"
(
    "user_id"  VARCHAR(128)                             NOT NULL,
    "group_id" VARCHAR(128)                             NOT NULL,
    "ctime"    TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    "mtime"    TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
    NOT        CLUSTER PRIMARY KEY("user_id", "group_id")
) STORAGE(ON "MAIN", CLUSTERBTR);

COMMENT
ON COLUMN "SCFS"."user_group_relation"."ctime" IS 'Create time';
COMMENT
ON COLUMN "SCFS"."user_group_relation"."group_id" IS 'User group ID';
COMMENT
ON COLUMN "SCFS"."user_group_relation"."mtime" IS 'Last updated time';
COMMENT
ON COLUMN "SCFS"."user_group_relation"."user_id" IS 'User ID';


CREATE
OR REPLACE  INDEX "INDEX25984906391700" ON "SCFS"."user_group_relation"("mtime" ASC) STORAGE(ON "MAIN", CLUSTERBTR) ;


-- data
INSERT INTO "SCFS"."auth_principal"("strategy_id","principal_id","principal_role") VALUES('fbca9bfa04ae4ead86e1ecf5811e32a9','65e4789a6d5b49669adf1e9e8387549c',1);

INSERT INTO "SCFS"."auth_strategy"("id","name","action","owner","comment","default","revision","flag","ctime","mtime") VALUES('fbca9bfa04ae4ead86e1ecf5811e32a9','(用户) polaris的默认策略','READ_WRITE','65e4789a6d5b49669adf1e9e8387549c','default admin',1,'fbca9bfa04ae4ead86e1ecf5811e32a9',0,TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'),TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'));

INSERT INTO "SCFS"."auth_strategy_resource"("strategy_id","res_type","res_id","ctime","mtime") VALUES('fbca9bfa04ae4ead86e1ecf5811e32a9',0,'*',TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'),TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "SCFS"."auth_strategy_resource"("strategy_id","res_type","res_id","ctime","mtime") VALUES('fbca9bfa04ae4ead86e1ecf5811e32a9',1,'*',TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'),TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'));
INSERT INTO "SCFS"."auth_strategy_resource"("strategy_id","res_type","res_id","ctime","mtime") VALUES('fbca9bfa04ae4ead86e1ecf5811e32a9',2,'*',TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'),TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'));

INSERT INTO "SCFS"."cl5_module"("module_id","interface_id","range_num","mtime") VALUES(3000001,1,0,TO_DATE('2024-04-05 16:48:18','YYYY-MM-DD HH24:MI:SS.FF'));

SET IDENTITY_INSERT "SCFS"."config_file" ON;
SET IDENTITY_INSERT "SCFS"."config_file" OFF;
SET IDENTITY_INSERT "SCFS"."config_file_group" ON;
SET IDENTITY_INSERT "SCFS"."config_file_group" OFF;
SET IDENTITY_INSERT "SCFS"."config_file_release" ON;
SET IDENTITY_INSERT "SCFS"."config_file_release" OFF;
SET IDENTITY_INSERT "SCFS"."config_file_release_history" ON;
SET IDENTITY_INSERT "SCFS"."config_file_release_history" OFF;
SET IDENTITY_INSERT "SCFS"."config_file_tag" ON;
SET IDENTITY_INSERT "SCFS"."config_file_tag" OFF;
SET IDENTITY_INSERT "SCFS"."config_file_template" ON;
INSERT INTO "SCFS"."config_file_template"("id","name","content","format","comment","create_time","create_by","modify_time","modify_by") VALUES(1,'spring-cloud-gateway-braining','{
        "rules":[
            {
                "conditions":[
                    {
                        "key":"${http.query.uid}",
                        "values":["10000"],
                        "operation":"EQUALS"
                    }
                ],
                "labels":[
                    {
                        "key":"env",
                        "value":"green"
                    }
                ]
            }
        ]
    }','json','Spring Cloud Gateway  染色规则',TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'),'polaris',TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'),'polaris');

SET IDENTITY_INSERT "SCFS"."config_file_template" OFF;
INSERT INTO "SCFS"."namespace"("name","comment","token","owner","flag","ctime","mtime","service_export_to","metadata") VALUES('Polaris','Polaris-server','2d1bfe5d12e04d54b8ee69e62494c7fd','polaris',0,TO_DATE('2019-09-06 15:55:07','YYYY-MM-DD HH24:MI:SS.FF'),TO_DATE('2019-09-06 15:55:07','YYYY-MM-DD HH24:MI:SS.FF'),null,null);
INSERT INTO "SCFS"."namespace"("name","comment","token","owner","flag","ctime","mtime","service_export_to","metadata") VALUES('default','Default Environment','e2e473081d3d4306b52264e49f7ce227','polaris',0,TO_DATE('2021-07-28 03:37:37','YYYY-MM-DD HH24:MI:SS.FF'),TO_DATE('2021-07-28 03:37:37','YYYY-MM-DD HH24:MI:SS.FF'),null,null);

INSERT INTO "SCFS"."service"("id","name","namespace","ports","business","department","cmdb_mod1","cmdb_mod2","cmdb_mod3","comment","token","revision","owner","flag","reference","refer_filter","platform_id","ctime","mtime","export_to") VALUES('fbca9bfa04ae4ead86e1ecf5811e32a9','polaris.checker','Polaris',null,'polaris',null,null,null,null,'polaris checker service','7d19c46de327408d8709ee7392b7700b','301b1e9f0bbd47a6b697e26e99dfe012','polaris',0,null,null,'',TO_DATE('2021-09-06 15:55:07','YYYY-MM-DD HH24:MI:SS.FF'),TO_DATE('2021-09-06 15:55:09','YYYY-MM-DD HH24:MI:SS.FF'),null);

INSERT INTO "SCFS"."start_lock"("lock_id","lock_key","server","mtime") VALUES(1,'sz','aaa',TO_DATE('2019-12-05 16:35:49','YYYY-MM-DD HH24:MI:SS.FF'));

INSERT INTO "SCFS"."user"("id","name","password","owner","source","mobile","email","token","token_enable","user_type","comment","flag","ctime","mtime") VALUES('65e4789a6d5b49669adf1e9e8387549c','polaris','$2a$10$3izWuZtE5SBdAtSZci.gs.iZ2pAn9I8hEqYrC6gwJp1dyjqQnrrum','','Polaris','12345678910','12345678910','nu/0WRA4EqSR1FagrjRj0fZwPXuGlMpX+zCuWu4uMqy8xr1vRjisSbA25aAC3mtU8MeeRsKhQiDAynUR09I=',1,20,'default polaris admin account',0,TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'),TO_DATE('2024-04-05 16:48:19','YYYY-MM-DD HH24:MI:SS.FF'));
