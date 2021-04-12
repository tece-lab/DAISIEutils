cors_vec <- c()
cors_vec_jump <- c()
for (i in 1:1000) {
  # 1e3 #####
  set.seed(1)
  sample_1e3_1 <- runif(1e3)

  jump_seed(1)
  sample_1e3_2 <- runif(1e3)

  cor_1e3_jump <- cor(sample_1e3_1, sample_1e3_2)
  cors_vec_jump[i] <- cor_1e3_jump

  set.seed(1)
  sample_1e3_1 <- runif(1e3)
  set.seed(2)
  sample_1e3_2 <- runif(1e3)

  cor_1e3 <- cor(sample_1e3_1, sample_1e3_2)
  cors_vec[i] <- cor_1e3
  print(i)
}
