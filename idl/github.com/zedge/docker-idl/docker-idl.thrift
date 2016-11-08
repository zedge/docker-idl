typedef string UUID
typedef i64 Timestamp

service DockerIdl {
    UUID echo(
        1: UUID uuid
    )
}
