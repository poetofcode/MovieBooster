package com.example.kmmshared.data.repository

import com.example.kmmshared.data.mock.mockPosts
import kotlinx.coroutines.delay


data class Post(
    val title: String,
    val text: String,
    val imageUrl: String
) {
    companion object {
        val DEFAULT = Post(
            title = "",
            text = "",
            imageUrl = "",
        )
    }
}

class PostRepository {

    suspend fun fetchPosts(searchQuery: String): List<Post> {
        delay(1000L)

        return mockPosts.filter {
            it.title.contains(searchQuery, ignoreCase = true)
        }
    }

}
