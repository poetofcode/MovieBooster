package com.example.kmmshared.domain

import kotlinx.coroutines.*

class PostUseCase(
    private val repository: PostRepository
) {

    fun fetchPosts(cb: (List<Post>) -> Unit) {
        CoroutineScope(SupervisorJob() + Dispatchers.Default).launch {
            val posts = repository.fetchPosts()

            withContext(Dispatchers.Main) {
                cb(posts)
            }
        }
    }

}