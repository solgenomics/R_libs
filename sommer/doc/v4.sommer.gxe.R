## -----------------------------------------------------------------------------
library(sommer)
data(DT_example)
DT <- DT_example
A <- A_example

ansSingle <- mmer(Yield~1,
              random= ~ vsr(Name, Gu=A),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansSingle)

# or
Ai <- as(solve(A), Class="sparseMatrix")
ansSingle <- mmec(Yield~1,
              random= ~ vsc(isc(Name), Gu=Ai),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansSingle)



## -----------------------------------------------------------------------------

ansMain <- mmer(Yield~Env,
              random= ~ vsr(Name, Gu=A),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansMain)

# or 

Ai <- as(solve(A), Class="sparseMatrix")
ansMain <- mmec(Yield~Env,
              random= ~ vsc(isc(Name), Gu=Ai),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansMain)



## -----------------------------------------------------------------------------

ansDG <- mmer(Yield~Env,
              random= ~ vsr(dsr(Env),Name, Gu=A),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansDG)

# or
Ai <- as(solve(A), Class="sparseMatrix")
ansDG <- mmec(Yield~Env,
              random= ~ vsc(dsc(Env),isc(Name), Gu=Ai),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansDG)



## -----------------------------------------------------------------------------
E <- diag(length(unique(DT$Env)))
rownames(E) <- colnames(E) <- unique(DT$Env)
EA <- kronecker(E,A, make.dimnames = TRUE)
ansCS <- mmer(Yield~Env,
              random= ~ vsr(Name, Gu=A) + vsr(Env:Name, Gu=EA),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansCS)

## or
E <- diag(length(unique(DT$Env)));rownames(E) <- colnames(E) <- unique(DT$Env)
Ei <- solve(E)
Ai <- solve(A)
EAi <- kronecker(Ei,Ai, make.dimnames = TRUE)
Ei <- as(Ei, Class="sparseMatrix")
Ai <- as(Ai, Class="sparseMatrix")
EAi <- as(EAi, Class="sparseMatrix")
ansCS <- mmec(Yield~Env,
              random= ~ vsc(isc(Name), Gu=Ai) + vsc(isc(Env:Name), Gu=EAi),
              rcov= ~ units, 
              data=DT, verbose = FALSE)
summary(ansCS)



## -----------------------------------------------------------------------------

ansUS <- mmer(Yield~Env,
              random= ~ vsr(usr(Env),Name, Gu=A),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansUS)
# adjust variance BLUPs by adding covariances
# ansUS$U[1:6] <- unsBLUP(ansUS$U[1:6])

# or
Ai <- solve(A)
Ai <- as(Ai, Class="sparseMatrix")
ansUS <- mmec(Yield~Env,
              random= ~ vsc(usc(Env),isc(Name), Gu=Ai),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansUS)



## -----------------------------------------------------------------------------
library(orthopolynom)
DT$EnvN <- as.numeric(as.factor(DT$Env))
ansRR <- mmer(Yield~Env,
              random= ~ vsr(leg(EnvN,1),Name),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansRR)

# or

ansRR <- mmec(Yield~Env,
              random= ~ vsc(dsc(leg(EnvN,1)),isc(Name)),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansRR)



## -----------------------------------------------------------------------------
library(orthopolynom)
DT$EnvN <- as.numeric(as.factor(DT$Env))
ansRR <- mmer(Yield~Env,
              random= ~ vsr(usr(leg(EnvN,1)),Name),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansRR)

# or

ansRR <- mmec(Yield~Env,
              random= ~ vsc(usc(leg(EnvN,1)),isc(Name)),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansRR)



## -----------------------------------------------------------------------------

E <- AR1(DT$Env) # can be AR1() or CS(), etc.
rownames(E) <- colnames(E) <- unique(DT$Env)
EA <- kronecker(E,A, make.dimnames = TRUE)
ansCS <- mmer(Yield~Env,
              random= ~ vsr(Name, Gu=A) + vsr(Env:Name, Gu=EA),
              rcov= ~ units,
              data=DT, verbose = FALSE)
summary(ansCS)



## -----------------------------------------------------------------------------

##########
## stage 1
## use mmer for dense field trials
##########
data(DT_h2)
DT <- DT_h2
head(DT)
envs <- unique(DT$Env)
BLUEL <- list()
XtXL <- list()
for(i in 1:length(envs)){
  ans1 <- mmer(y~Name-1,
                random=~Block,
                verbose=FALSE,
                data=droplevels(DT[which(DT$Env == envs[i]),]
               )
  )
  ans1$Beta$Env <- envs[i]
  
  BLUEL[[i]] <- ans1$Beta
  XtXL[[i]] <- ans1$VarBeta
}

DT2 <- do.call(rbind, BLUEL)
OM <- do.call(adiag1,XtXL)

##########
## stage 2
## use mmec for sparse equation
##########
m <- matrix(1/var(DT2$Estimate, na.rm = TRUE))
ans2 <- mmec(Estimate~Env,
             random=~Effect + Env:Effect, 
             rcov=~vsc(isc(units,thetaC = matrix(3), theta = m)),
             W=OM, tolParConvNorm = .001, 
             verbose=FALSE,
             data=DT2
             )
summary(ans2)$varcomp


