package com.example.kmmshared.domain

import com.example.kmmshared.data.repository.Post
import com.example.kmmshared.data.repository.PostRepository
import kotlinx.coroutines.*

class PostUseCase(
    private val repository: PostRepository
) {

    fun fetchPosts(searchQuery: String, cb: (List<Post>) -> Unit) {
        CoroutineScope(Job() + Dispatchers.Default).launch {
            val posts = repository.fetchPosts(searchQuery = searchQuery)

            withContext(Dispatchers.Main) {
                cb(posts)
            }
        }
    }

}