package com.salesianostriana.dam.fitapp.security;


import com.salesianostriana.dam.fitapp.security.jwt.JwtAccessDeniedHandler;
import com.salesianostriana.dam.fitapp.security.jwt.JwtAuthorizationFilter;;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;

@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Configuration
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationEntryPoint authenticationEntryPoint;
    private final JwtAuthorizationFilter filter;
    private final JwtAccessDeniedHandler accessDeniedHandler;


    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().configurationSource(corsConfigurationSource());
        http.csrf().disable()
                .exceptionHandling()
                .authenticationEntryPoint(authenticationEntryPoint)
                .accessDeniedHandler(accessDeniedHandler)
                .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()

                //REGISTRO/LOGIN

                    .antMatchers(HttpMethod.POST, "/auth/register").permitAll()
                    .antMatchers(HttpMethod.POST, "/auth/login").permitAll()
                    .antMatchers(HttpMethod.GET, "/me").authenticated()
                    .antMatchers(HttpMethod.GET,"/download/{filename:.+}/**").permitAll()


                //USUARIOS
                .antMatchers(HttpMethod.GET, "/user/**").permitAll()


                //EJERCICIOS
                .antMatchers(HttpMethod.GET, "/exercise/**").authenticated()
                .antMatchers(HttpMethod.PUT, "/exercise/**").authenticated()
                .antMatchers(HttpMethod.POST, "/exercise/**").authenticated()
                .antMatchers(HttpMethod.DELETE, "/exercise/**").authenticated()

                //DIETA
                .antMatchers(HttpMethod.GET, "/diet/**").authenticated()
                .antMatchers(HttpMethod.PUT, "/diet/**").authenticated()
                .antMatchers(HttpMethod.POST, "/diet/**").authenticated()
                .antMatchers(HttpMethod.DELETE, "/diet/**").authenticated()




                .antMatchers("/h2-console/**", "/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html").permitAll()
                    .anyRequest().authenticated();


        http.addFilterBefore(filter, UsernamePasswordAuthenticationFilter.class);

        // Para dar acceso a h2
        http.headers().frameOptions().disable();


    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("*"));
        configuration.setAllowedMethods(Arrays.asList("GET","POST","DELETE"));
        configuration.setAllowedHeaders(Collections.singletonList("*"));
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
