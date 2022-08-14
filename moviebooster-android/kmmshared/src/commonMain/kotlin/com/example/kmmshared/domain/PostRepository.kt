package com.example.kmmshared.domain

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

    suspend fun fetchPosts() : List<Post> {
        delay(1000L)
        // return (0..10).map { Post(title = "Post №$it", text = "Issue text", imageUrl = "") }
        return listOf(
            Post.DEFAULT.copy(title = "Red"),
            Post.DEFAULT.copy(title = "Blue"),
            Post.DEFAULT.copy(title = "Yellow"),
            Post.DEFAULT.copy(title = "Black"),
            Post.DEFAULT.copy(title = "Brown"),
            Post.DEFAULT.copy(title = "Green"),
            Post.DEFAULT.copy(title = "Gray"),
            Post.DEFAULT.copy(title = "White"),
            Post.DEFAULT.copy(title = "Light cyan"),
            Post.DEFAULT.copy(title = "Dark green"),
            Post.DEFAULT.copy(title = "Silver"),
        )
    }

}