package com.example.kmmshared.domain

import kotlinx.coroutines.delay


data class Post(
    val title: String,
    val text: String,
    val imageUrl: String
)

class PostRepository {

    suspend fun fetchPosts() : List<Post> {
        delay(1000L)
        return (0..10).map { Post(title = "Post №$it", text = "Issue text", imageUrl = "") }
    }

}