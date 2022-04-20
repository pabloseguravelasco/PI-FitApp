package com.salesianostriana.dam.fitapp.security.jwt;


import com.salesianostriana.dam.fitapp.security.users.model.UserEntity;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.UUID;

@Log
@Service
public class JwtProvider {

    public static final String TOKEN_TYPE = "JWT";
    public static final String TOKEN_HEADER = "Authorization";
    public static final String TOKEN_PREFIX = "Bearer ";

    @Value("${jwt.secret:elsecretoibericoeselquemasmegusta}")
    private String jwtSecret;

    @Value("${jwt.duration:86400}") // 1 día
    private int jwtLifeInSeconds;

    private JwtParser parser;

    @PostConstruct
    public void init(){

        parser = Jwts.parserBuilder().setSigningKey(Keys.hmacShaKeyFor(jwtSecret.getBytes())).build();
    }

    public String generateToken(Authentication authentication) {

        UserEntity user = (UserEntity) authentication.getPrincipal();

        Date tokenExpirationDate = Date
                .from(LocalDateTime
                        .now()
                        .plusSeconds(jwtLifeInSeconds)
                        .atZone(ZoneId.systemDefault()).toInstant());


        return Jwts.builder()
                .setHeaderParam("typ", TOKEN_TYPE)
                .setSubject(user.getId().toString())
                .setIssuedAt(tokenExpirationDate)
                .claim("nickname", user.getNickname())
                .claim("role", user.getRole().name())
                .signWith(Keys.hmacShaKeyFor(jwtSecret.getBytes()))//signWith(Keys.hmacShaKeyFor(jwtSecret.getBytes()))
                .compact();


    }


    public UUID getUserIdFromJwt(String token) {
        return UUID.fromString(parser.parseClaimsJws(token).getBody().getSubject());
    }


    public boolean validateToken(String token) {

        try {
            parser.parseClaimsJws(token);
            return true;
        } catch (SignatureException | MalformedJwtException | ExpiredJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
            log.info("Error con el token: " + ex.getMessage());
        }
        return false;

    }


}
