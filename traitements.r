install.packages("RPostgreSQL", repos='http://cran.us.r-project.org')
library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "lizmap",
				host = "localhost", port = 5432,
				user = "postgres", password= "postgres")
				
data_sel <- dbGetQuery(con, "
	SELECT fclass, occupation from poi84 where fclass IN(
	SELECT fclass FROM poi84 GROUP BY fclass HAVING count(fclass)>100)")

head(data_sel, n=10)

variance <- aov (occupation ~ fclass, data=data_sel)
summary(variance)