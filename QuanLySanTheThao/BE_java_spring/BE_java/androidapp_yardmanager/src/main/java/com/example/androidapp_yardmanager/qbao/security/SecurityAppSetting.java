package com.example.androidapp_yardmanager.qbao.security;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import javax.crypto.spec.SecretKeySpec;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityAppSetting {
    private final String[] link_not_securiry = {"/user/api/v1/test_server","/user/api/v1/login","/user/api/v1/sigup", "/user/api/v1/search_yard","/user/api/v1/yard_detail/{id}",
    "/user/api/v1/address_yard","user/api/v1/rentyard","user/api/v1/user/{idUser_}","user/api/v1/user","user/api/v1/rentyard/{idUser_}"};

    @Value("${jwt.create_token_key}")
    private String sereckey;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {


        http.authorizeHttpRequests(rq_  -> rq_
                .requestMatchers(HttpMethod.GET,link_not_securiry).permitAll()
                .requestMatchers(HttpMethod.POST,link_not_securiry).permitAll()
                .requestMatchers(HttpMethod.PUT,link_not_securiry).permitAll()
                .requestMatchers(HttpMethod.DELETE,link_not_securiry).permitAll()

                .anyRequest().authenticated());

        http.csrf(AbstractHttpConfigurer::disable);

        http.oauth2ResourceServer(oauth2 -> oauth2
                .jwt(jwtConfigurer -> jwtConfigurer.decoder(jwt_decoder())));

        http.cors(Customizer.withDefaults());

        return http.build();
    }

    @Bean
    JwtAuthenticationConverter jwtAuthenticationConverter(){
        JwtGrantedAuthoritiesConverter jwt_ = new JwtGrantedAuthoritiesConverter();
        jwt_.setAuthorityPrefix("ROLE_");
        JwtAuthenticationConverter jwt__ = new JwtAuthenticationConverter();
        jwt__.setJwtGrantedAuthoritiesConverter(jwt_);
        return jwt__;
    }


    @Bean
    JwtDecoder jwt_decoder(){
        SecretKeySpec spec = new SecretKeySpec(sereckey.getBytes(),"HS512");
        return NimbusJwtDecoder
                .withSecretKey(spec)
                .macAlgorithm(MacAlgorithm.HS512)
                .build();
    }


    @Bean
    public CorsFilter corsFilter(){
        CorsConfiguration corsConfiguration = new CorsConfiguration();
        corsConfiguration.addAllowedOrigin("*");
        corsConfiguration.addAllowedMethod("*");
        corsConfiguration.addAllowedHeader("*");
        UrlBasedCorsConfigurationSource urlBasedCorsConfigurationSource = new UrlBasedCorsConfigurationSource();
        urlBasedCorsConfigurationSource.registerCorsConfiguration("/**",corsConfiguration);
        return new CorsFilter(urlBasedCorsConfigurationSource);

    }
}
